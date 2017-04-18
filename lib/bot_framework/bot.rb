module BotFramework
  class Bot
    class << self
      attr_accessor :recognizer

      def on(event, &block)
        hooks[event] = block
      end

      def on_intent(intent, &block)
        intent_callbacks[intent] = block
      end

      def trigger(event, *args)
        # hooks.fetch(event).call(*args)
        if hooks[event].nil?
          p "No call back registered for #{event}"
          return false
        end
        instance_exec *args, &hooks.fetch(event)
      end

      def trigger_intent_call_back(intent, *args)
        if intent_callbacks[intent].nil?
          p "No call back registered for #{intent}"
          trigger_intent_call_back(:default, *args) if intent_callbacks[:default]
          return false
         end
        instance_exec *args, &intent_callbacks.fetch(intent)
      end

      def receive(payload)
        trigger(payload.type.to_sym)
        # Run on default
        trigger(:activity, payload)
        return unless recognizer
        recognizer.recognize(message: payload.as_json) do |_error, intents|
          trigger_intent_call_back(intents[:intent], payload, intents) if intents[:intent]
        end
      end

      def reply(activity, message = '')
        activity.reply(message)
      end

      def user_data=(data)
        p "Data set as #{data}"
      end

      def set_conversation_data(activity, data)
        data = BotFramework::BotData.new(data: data, e_tag: '*') if data.is_a? Hash
        BotFramework::BotState.new('').set_conversation_data('channel_id' => activity.channel_id,
                                                             'conversation_id' => activity.conversation.id,
                                                             'bot_data' => data)
      end

      def conversation_data(activity)
        BotFramework::BotState.new('').get_conversation_data(
          'channel_id' => activity.channel_id,
          'conversation_id' => activity.conversation.id
        ).data || {}
      end

      def hooks
        @hooks ||= {}
      end

      def reset_hooks
        @hooks = {}
      end

      def intent_callbacks
        @intent_callbacks ||= {}
      end
    end
  end
end
