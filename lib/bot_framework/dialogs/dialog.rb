require_relative '../session'
require_relative 'action_set'
module BotFramework
  # Abstract class for dialog
  module Dialogs
    class Dialog < ActionSet
      RESUME_REASONS = %i[completed not_completed canceled back forward reprompt].freeze
      def begin(session, _opts = {})
        reply_recieved(session)
      end

      def reply_recieved(_session, _recognize_result = {})
        raise NotImplementedError
      end

      def dialog_resumed(session, result)
        session.error(result[:error]) if result[:error]
      end

      def recognize(_context)
        yield nil, { score: 0.1 }
      end
    end
  end
end
