module BotFramework
  class Bot
    class << self
      extend Gem::Deprecate
      attr_accessor :recognizers

      def on(event, &block)
        hooks[event] = block
      end

      def on_intent(intent, &block)
        intent_callbacks[intent] = block
      end

      def recognizer=(recognizer)
        warn 'DEPRECATED: Use add_recognizer method instead'
        add_recognizer(recognizer)
      end
      deprecate :recognizer=, :add_recognizer, 2016, 5

      def add_recognizer(recognizer)
        recognizers << recognizer
      end

      def recognizers
        @recognizers ||= []
      end

      def trigger(event, *args)
        # hooks.fetch(event).call(*args)
        if hooks[event].nil?
          BotFramework.logger.info "No call back registered for #{event}"
          return false
        end
        instance_exec(*args, &hooks.fetch(event))
      end

      def trigger_intent_call_back(intent, *args)
        if intent_callbacks[intent].nil?
          BotFramework.logger.info "No call back registered for #{intent}"
          trigger_intent_call_back(:default, *args) if intent_callbacks[:default]
          return false
        end
        instance_exec(*args, &intent_callbacks.fetch(intent))
      end

      def receive(payload)
        trigger(payload.type.to_sym, payload)
        # Run on default
        trigger(:activity, payload)
        recognizers.each do |recognizer|
          recognizer.recognize(message: payload.as_json) do |_error, intents|
            trigger_intent_call_back(intents[:intent], payload, intents) if intents[:intent]
          end
        end
      end

      def reply(activity, message = '')
        activity.reply(message)
      end

      def user_data=(data)
        BotFramework.logger.info "Data set as #{data}"
      end

      def set_conversation_data(activity, data)
        data = BotFramework::BotData.new(data: data, e_tag: '*') if data.is_a? Hash
        BotFramework::BotState.new(activity.service_url)
                              .set_conversation_data('channel_id' => activity.channel_id,
                                                     'conversation_id' => activity.conversation.id,
                                                     'bot_data' => data)
      end

      def conversation_data(activity)
        BotFramework::BotState.new(activity.service_url).get_conversation_data(
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
