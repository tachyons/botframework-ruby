module BotFramework
  class Session #< Events::EventEmitter
    attr_accessor :library, :message, :user_data, :conversation_data, :private_conversation_data,
                  :session_state, :dialog_state, :localizer
    def initialize(options)
      super
      @library = options[:library]
      @localizer = options[:localizer]
      @msg_sent = false
      @is_reset = false
      @last_send_time = Time.now # TODO: Move to proc?
      @batch = []
      @batch_timer = Timers::Group.new
      @batch_started = false
      @sending_batch = false
      @in_middleware = false
      @_locale = nil

      @options = options || {
        on_save: nil,
        on_send: nil,
        library: nil,
        localizer: nil,
        middleware: nil,
        dialog_id: nil,
        dialog_args: nil,
        auto_batch_delay: nil,
        dialog_error_message: nil,
        actions: nil
      }
      @auto_batch_delay = 250 unless options[:auto_batch_delay].is_a? Integer
      @timers = Timers::Group.new
    end

    def to_recognize_context
      {
        message: message,
        user_data: user_data,
        conversation_data: conversation_data,
        private_conversation_data: private_conversation_data,
        localizer: localizer,
        dialog_stack: dialog_stack,
        preferred_locale: preferred_locale,
        get_text: get_text,
        nget_text: nget_text,
        locale: preferred_locale
      }
    end

    def dispatch(session_state, message)
      index = 0
      session = self
      now = Time.now
      middleware = @options[:middleware] || []

      _next = lambda do
        handler = middleware[index] if index < middleware.length
        if handler
          index += 1
          handler(session, _next)
        else
          @in_middleware = false
          @session_state[:last_acess] = now
          done
        end
      end
      session_state ||= { call_stack: [], last_acess: Time.now, version: 0.0 }
      # Making sure that dialog is properly initialized
      cur = cur_dialog
      self.dialog_data = cur.state if cur
      # Dispatch message
      message ||= { text: '' }
      message[:type] ||= 'message'
      # Ensure that localized prompts are loaded
      # TODO
      self
    end

    def error error
      logger.info "Session error"
      if options[:dialog_error_message] 
        end_conversation(options[:dialog_error_message])
      else
        #TODO Add localisation
        locale= preferred_locale
        end_conversation ("Error in conversation")
      end

      # TODO Log error

    end
    
    def preferred_locale(locale=nil,&block)
      if locale
        @_locale = locale
        @user_data['BotBuilder.Data.PreferredLocale'] = locale if @user_data
        @localizer.load() if @localizer #TODO
      elsif !@_locale
        if @user_data && @user_data['BotBuilder.Data.PreferredLocale']
          @_locale = @user_data['BotBuilder.Data.PreferredLocale']
        elsif @message && @message[:text_locale]
          @_locale = @message[:text_locale]
        elsif @localizer 
          @_locale = @localizer[:default_locale]
        end
      end
      @_locale
    end
    
    # Gets and formats localized text string
    def gettext(message_id,options={})
      #TODO
      #stub
    end

    # Gets and formats the singular/plural form of a localized text string. 
    def ngettext(message_id,message_id_plural,count)
    end    

    # Manually save current session state
    def save
      logger.info 'Session.save'
      start_batch
      self
    end

    def send(message,args=[])
      args.unshift(@cur_library_name,message)
      send_localized(args,message)
    end

    def send_localized(localization_namspace,message,args=[])
      #TODO Incomplete
      @msg_sent = true
      m = {text: message}
      prepare_message(m)
      @batch << m
      self
    end

    # Sends a typing indicator to the user
    def send_typing
      @msg_sent = true
      m = { type: 'typing' }
      m = prepare_message(m)
      @batch.push(m)
      logger.info 'Send Typing'
      send_batch 
    end

    def send_batch
      logger.info "Sending batch with elements #{@batch.count}"
      return if sending_batch?
      # TODO: timer
      @batch_timer = nil
      batch = @batch
      @batch_started = false
      @sending_batch = true
      cur = cur_dialog
      cur.state = @dialog_data
      options[:on_save] = proc do |err|
        if err
          @sending_batch = false
          case (err.code || '')
          when 'EBADMSG'
          when 'EMSGSIZE'
            # Something went wrong , let's reset everything
            @user_data = {}
            @batch = []
            end_conversation(@options[:dialog_error_message] || 'Something went wrong and we need to startover')
          end
          yield(err) if block_given?
        else
          if batch.length
            options[:on_send].call(batch) do |err|
              @sending_batch = false
              start_batch if @batch_started # What is this :o
              yield(err) if block_given?
            end
          else
            @sending_batch = false
            start_batch if @batch_started
            yield(err) if block_given?
          end
        end
      end
    end

    
    # Begin a new dialog
    def begin_dialog(id, args = nil)
      logger.info "Beginning new dialog #{id}"
      id = resolve_dialog_id(id)
      dialog = find_dialog(id)
      raise "Dialog #{id} Not found" unless dialog
      push_dialog(id: id, state: {})
      start_batch
      dialog.begin(self, args)
      self
    end

    def replace_dialog(id, args = nil)
      logger.info "Session replace dialog #{id}"
      id = resolve_dialog_id(id)
      dialog = find_dialog(id)
      raise "Dialog #{id} Not found" unless dialog

      # Update the stack and start dialog
      pop_dialog
      push_dialog(id: id, state: {})
      start_batch
      dialog.begin(self, args)
      self
    end

    # End conversation with the user
    def end_conversation(message = nil, _args = {})
      if message
        # TODO: sent message
      end
      # Clear private conversation data
      @private_conversation_data = {}

      # Clear stack and save
      logger.info 'End conversation'
      ss = @session_state
      ss.call_stack = []
      send_batch
      self
    end

    def end_dialog(message = nil, args = {})
      if message
        # TODO: end_dialog_with_result
      end
      cur = cur_dialog
      if cur
        if message
          m = if (message.is_a? String) || (message.is_a? Array)
                create_message(cur_library_name, message, args)
              else
                message
              end
          @msg_sent = true
          prepare_message(m)
          @batch.push(m)
        end

        # Pop the dialog of the stack and resume the parent
        logger.info 'Session.end_dialog'
        child_id = cur.id
        cur = pop_dialog
        start_batch
        if cur
          dialog = find_dialog(cur.id)
          if dialog
            dialog.dialog_resumed(self, resumed: :completed, response: true, child_id: child_id)
          else
            # Bad dialog !! , we should never reach here
            raise "Can't resume , missing parent"
          end
        end
      end
    end

    # Ends current dialog and returns a value to the caller
    def end_dialog_with_result(result)
      # Validate call stack
      cur = cur_dialog
      if cur
        # Validate the result
        result ||= {}
        result[:resumed] ||= :completed
        result.child_id = cur.id
        logger.info 'Session.end_dialog_with_result'

        # Pop dialog of the stack and resume parent dialog
        cur = pop_dialog
        start_batch
        if cur
          dialog = find_dialog(cur.id)
          if dialog
            dialog.dialog_resumed(self, result)
          else
            # Bad dialog state
            raise "Can't resume , missing parent dialog"
          end
        end
      end
      self
    end

    def cancel_dialog
    end

    def reset
    end

    ############### Dialog Stack Management ############################33

    # Gets and Sets current dialog stack
    def dialog_stack(new_stack = nil)
      if new_stack
        # Update stack and dialog data

        stack = @session_state[:call_stack] = new_stack || []
        @dialog_data = stack.empty? nil || stack.last
      else
        # Copy over dialog data to slack
        stack = @session_state[:call_stack] || []
        stack.last.state = @dialog_data || {}
      end
      stack
    end

    # Clears the current Dialog stack
    def clear_dialog_stack
      @session_state[:call_stack] = []
      @dialog_data = nil
    end

    # Enumerates all a stacks dialog entries in either a forward or reverse direction.
    def self.forEachDialogStackEntry(stack)
      stack.each { |item| yield(item) }
    end

    # Searches a dialog stack for a specific dialog, in either a forward or reverse direction, returning its index.
    def self.findEachDialogStackEntry(stack, dialog_id)
      stack.each_with_index do |item, index|
        return index if item[:id] = dialog_id
      end
      -1
    end

    # Returns a active stack entry or nil
    def self.active_dialog_stack_entry(stack)
      stack.last || nil
    end

    # Pushes a new dialog into stack and return it as active dialog
    def self.push_dialog_stack_entry(statck, entry)
      entry[:state] ||= {}
      statck ||= []
      stack.push(entry)
      entry
    end

    # Pop active dialog out of the stack
    def self.pop_dialog_stack_entry(stack)
      stack.pop if stack
      Session.active_dialog_stack_entry(stack)
    end

    #  Deletes all dialog stack entries starting with the specified index and returns the new active dialog.
    def self.prune_dialog_stack(_stack, _start)
    end

    # Ensures that all of the entries on a dialog stack reference valid dialogs within a library hierarchy.
    def self.validate_dialog_stack(_stack, _root)
    end

    ## Message routing
    #########################

    # Dispatches handling of the current message to the active dialog stack entry.
    def route_to_active_dialog
    end

    private

    def start_batch
      @batch_started = true
      unless @sending_batch
        @batch_timer.cancel if @batch_timer
        # TODO: send_batch after config[:auto_batch_delay] seconds
        @batch_timer = @timers.after(config[:auto_batch_delay]) do
          send_batch
        end
      end
    end

    def create_message
    end

    def prepare_message(msg)
      msg[:type] ||= 'message'
      msg[:address] ||= message[:address]
      msg[:text_locale] ||= message[:text_locale]
      msg
    end

    def vget_text
    end

    def validate_call_stack
    end

    def resolve_dialog_id
    end

    def cur_library_name
    end

    def find_dialog
    end

    def push_dialog
    end

    def pop_dialog
    end

    def delete_dialogs
    end

    def cur_dialog
      ss = @session_sate
      cur = ss.call_stack.last unless ss.call_stack.empty?
      cur
    end
  end
end
