module BotFramework
  module Dialogs
    class RegExpRecognizer
      attr_accessor :intent, :expressions
      def initialize(intent,expressions)
        @intent = intent
        if expressions.is_a? Regexp
          @expressions = {'*': expressions}
        else
          @expressions = expressions || {}
        end
      end

      def recognize(context)
        raise ArgumentError, "context must be a hash" unless context.is_a? Hash
        result = {score: 0.0, intent: nil}
        if context.fetch(:message, {}).fetch(:text, nil)
          utterance = context[:message][:text]
          locale = context[:message][:locale] || :*
          exp = @expressions[locale] ? @expressions[locale] : @expressions[:*]
          if exp
            matches = exp.match(utterance)
            if matches
              matched = matches.to_s
              result[:score] = matched.length / utterance.length
              result[:intent] = intent
              result[:expression] = exp
              result[:matched] = matches
            end
            yield nil, result
          else
            yield(ExpressionNotFoundForLocale, nil)
          end
        else
          yield(nil, result)
        end
      end
    end
  end
end
