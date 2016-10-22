module BotFramework
  class Bot
    class << self
      def on(event, &block)
        hooks[event] = block
      end

      def trigger(event, *args)
        hooks.fetch(event).call(*args)
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

      def hooks
        @hooks ||= {}
      end

      def reset_hooks
        @hooks = {}
      end
    end
  end
end
