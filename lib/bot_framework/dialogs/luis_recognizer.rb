module BotFramework
  module Dialogs
    class LuisRecognizer
      def initialize(models)
        @models = { '*' => models }
      end

      def recognize(context)
        result = { score: 0.0, intent: nil }
        if context && context[:message] && context[:message][:text]
          utterance = context[:message]
          locale = context[:locale] || '*'
          model = @models[locale] || @models['*']
          if model
          end
        end
      end

      def self.recognize(utterance, model_uri)
        uri = model_uri.strip
        uri += '&q=' unless uri.end_with? '&q='
        uri += URI.encode_www_form_component(utterance || '')
        result = JSON.parse HTTParty.get(uri).body
        result['intents'] ||= []
        result['entities'] ||= []
        if result['topScoringIntent'] && result['intents'].empty?
          result['intents'] << result['topScoringIntent']
        end

        if result['intents'].length == 1 && (result['intents'].first[:score].is_a? Numeric)
          result['intents'].first['score'] = 1.0
        end
        result
      end
    end
  end
end
