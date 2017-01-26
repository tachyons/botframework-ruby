module BotFramework
  module Dialogs
    class LuisRecognizer
      def initialize(models)
        @models = { '*' => models }
      end

      def recognize(context,&block)
        result = { score: 0.0, intent: nil }
        if context && context[:message] && context[:message][:text]
          utterance = context[:message][:text]
          locale = context[:locale] || '*'
          model = @models[locale] || @models['*']
          if model
            LuisRecognizer.recognize(utterance,model) do |error, intents, entities|
              unless error
                result[:intents] = intents
                result[:entities] = entities

                top = intents.max {|intent| intent[score]}
                if top
                  result[:score] = top[:score]
                  result[:intent] = top[:intent]
                  case top[:intent].downcase
                  when 'builtin.intent.none'
                  when 'none'
                    result[:score] = 0.1
                  end
                end
                yield nil, result
              else
                yield "Error",nil
              end
              yield nil, result
            end
          else
            yield StandardError.new("Luis model not found for locale #{locale}"),nil
          end
        else
          yield nil,result
        end

      end

      def self.recognize(utterance, model_uri)
        uri = model_uri.strip
        uri += '&q=' unless uri.end_with? '&q='
        uri += URI.encode_www_form_component(utterance || '')
        result = JSON.parse HTTParty.get(uri).body
        # Symbolize keys
        result = result.inject({}){|temp,(k,v)| temp[k.to_sym] = v; temp}
        result[:intents] ||= []
        result[:entities] ||= []
        if result[:topScoringIntent] && result[:intents].empty?
          result[:intents] << result[:topScoringIntent]
        end

        if result[:intents].length == 1 && (result[:intents].first[:score].is_a? Numeric)
          result[:intents].first[:score] = 1.0
        end
        # Symbolize keys
        result[:intents].map! do |intent|
          intent.inject({}){|temp,(k,v)| temp[k.to_sym] = v; temp}
        end

        result[:entities].map! do |entity|
          entity.inject({}){|temp,(k,v)| temp[k.to_sym] = v; temp}
        end
        yield nil, result[:intents], result[:entities]
      end
    end
  end
end
