module BotFramework
  class Bot
    class << self
      def on(event, &block)
        hooks[event] = block
      end

      def trigger(event, *args)
        # hooks.fetch(event).call(*args)
        instance_exec *args, &hooks.fetch(event)
      end

      def receive(payload)
        trigger(:activity, payload)
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
    end
  end
end
