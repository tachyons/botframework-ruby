require_relative '../session'
require_relative 'action_set'
module BotFramework
  # Abstract class for dialog
  module Dialogs
    class SimpleDialog < Dialog
      def initialize
        raise "No block given" unless block_given?
        super
      end

      def begin(session, opts = {})
        reply_recieved(session)
      end

      def reply_recieved(session,recognize_result = {})
        raise NotImplementedError
      end
      
      def dialog_resumed(session, result)
        session.error(result[:error]) if result[:error]
      end
      
      def recognize(context)
        yield nil, {score: 0.1}
      end
    end
  end
end
