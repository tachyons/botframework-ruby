module BotFramework
  module Dialogs
    class ActionSet
      attr_accessor :actions

      def initialize
        @actions = {}
      end

      def clone(copy_to = nil)
        obj = copy_to || ActionSet.new
        obj.trigger = self.trigger
        actions.each do |name|
          object.actions[name] = actions[name]
        end
        obj
      end

      def add_dialog_trigger(actions, dialog_id)
        if trigger
          trigger.localization_namespace = dialog_id.split(":").first
          actions.begin_dialog_action(dialog_id, dialog_id, trigger)
        end
      end

      def find_action_routes(context, callback)
      end

      def select_action_route(session,route)
      end

      def dialog_interrupted(session,dialog_id,dialog_ags)

      end

      def begin_dialog_action(name, id, options = {}); end

      def end_conversation_action(name, message, options); end

      def reload_action(name, message, options); end

      def cancel_action(name, message, options)
        action(name, options) do |args, session|
          if options[:confirm_prompt]
            session.begin_dialog('BotBuilder:ConfirmCancel', localization_namespace: nil,
                                                             confirm_prompt: nil,
                                                             dialog_index: nil,
                                                             msg: message)
          elsif message.present?
            session.send_localized(args.library_name, message)
          else
            session.cancel_dialog(args.dialog_index)
          end
        end
      end

      def select_action_routes; end

      def trigger_action; end

      private

      def action(_name, _options = {})
        yield
      end

      def recognize_action(message); end
    end
  end
end
