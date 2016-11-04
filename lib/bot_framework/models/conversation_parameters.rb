module BotFramework
  class ConversationParameters < Base
    # IsGroup
    attr_accessor :is_group

    # The bot address for this conversation
    attr_accessor :bot

    # Members to add to the conversation
    attr_accessor :members

    # (Optional) Topic of the conversation (if supported by the channel)
    attr_accessor :topic_name

    # Attribute type mapping.
    def self.swagger_types
      {
        is_group: :BOOLEAN,
        bot: :ChannelAccount,
        members: :'Array<ChannelAccount>',
        topic_name: :String
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.is_group = attributes[:isGroup] if attributes.key?(:isGroup)

      self.bot = attributes[:bot] if attributes.key?(:bot)

      if attributes.key?(:members)
        if (value = attributes[:members]).is_a?(Array)
          self.members = value
        end
      end

      self.topic_name = attributes[:topicName] if attributes.key?(:topicName)
    end
  end
end
