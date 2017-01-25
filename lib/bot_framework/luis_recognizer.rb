module BotFramework
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

    def self.recognize
    end
  end
end
