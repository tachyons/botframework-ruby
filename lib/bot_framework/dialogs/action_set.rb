module BotFrameork
  module Dialogs
    class ActionSet
      attr_accessor :actions

      def initialize()
        @actions = {}
      end

      def add_dialog_trigger(actions,dialog_id)
        if trigger
          actions.begin_dialog_action(dialog_id,dialog_id,trigger)
        end
      end

      def begin_dialog_action(name,id,options={})
      end

      def end_conversation_action(name,message,options)
      end
      
      def reload_action(name,message,options)
      end

      def cancel_action(name,message,options)
        action(name,options) do |args,session|
          if options[:confirm_prompt]
            session.begin_dialog('BotBuilder:ConfirmCancel',{
              localization_namespace: nil,
              confirm_prompt: nil,
              dialog_index: nil,
              msg: message
            })
          elsif message.present?
            session.send_localized(args.library_name,message)
          else
            session.cancel_dialog(args.dialog_index)
          end
        end
      end

      def select_action_routes
      end

      def trigger_action
      end

      private

      def action(name,options={})
        yield
      end

      def recognize_action(message)
        
      end
    end
  end
end
