module BotFramework
  class Session
    attr_accessor :library, :message, :user_data, :conversation_data, :private_conversation_data,
                  :session_state, :dialog_state, :localizer
    def initialize(options)
      @library = options[:library]
      @localizer = options[:localizer]
      @options = {
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
    end

    def dispatch(_session_state, message)
      index = 0
      session = self
      _next = Proc.new
      session_sate ||= { call_stack: [], last_acess: Time.now, version: 0.0 }
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

    def save
      logger.info 'Session.save'
      start_batch
      self
    end

    def send(message)
    end

    def send_typing
      @msg_sent = true
      m = { type: 'typing' }
      m = prepare_message(m)
      @batch.push(m)
      logger.info 'Send Typing'
      send_batch
      self
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

    def preferred_locale
      :en
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

    def prepare_message(msg)
      msg[:type] ||= 'message'
      msg[:address] ||= message[:address]
      msg[:text_locale] ||= message[:text_locale]
      msg
    end

    def cur_dialog
      ss = @session_sate
      cur = ss.call_stack.last unless ss.call_stack.empty?
      cur
    end
  end
end
