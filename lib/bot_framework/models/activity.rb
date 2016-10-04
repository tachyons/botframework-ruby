module BotFramework
  class Activity < Base
    # The type of the activity [message|contactRelationUpdate|converationUpdate|typing]
    attr_accessor :type

    # Id for the activity
    attr_accessor :id

    # Time when message was sent
    attr_accessor :timestamp

    # Service endpoint
    attr_accessor :service_url

    # ChannelId the activity was on
    attr_accessor :channel_id

    # Sender address
    attr_accessor :from

    # Conversation
    attr_accessor :conversation

    # (Outbound to bot only) Bot's address that received the message
    attr_accessor :recipient

    # Format of text fields [plain|markdown] Default:markdown
    attr_accessor :text_format

    # AttachmentLayout - hint for how to deal with multiple attachments Values: [list|carousel] Default:list
    attr_accessor :attachment_layout

    # Array of address added
    attr_accessor :members_added

    # Array of addresses removed
    attr_accessor :members_removed

    # Conversations new topic name
    attr_accessor :topic_name

    # the previous history of the channel was disclosed
    attr_accessor :history_disclosed

    # The language code of the Text field
    attr_accessor :locale

    # Content for the message
    attr_accessor :text

    # Text to display if you can't render cards
    attr_accessor :summary

    # Attachments
    attr_accessor :attachments

    # Collection of Entity objects, each of which contains metadata about this activity. Each Entity object is typed.
    attr_accessor :entities

    # Channel specific payload
    attr_accessor :channel_data

    # ContactAdded/Removed action
    attr_accessor :action

    # the original id this message is a response to
    attr_accessor :reply_to_id

    # Attribute type mapping.
    def self.swagger_types
      {
        type: :String,
        id: :String,
        timestamp: :DateTime,
        service_url: :String,
        channel_id: :String,
        from: :ChannelAccount,
        conversation: :ConversationAccount,
        recipient: :ChannelAccount,
        text_format: :String,
        attachment_layout: :String,
        members_added: :'Array<ChannelAccount>',
        members_removed: :'Array<ChannelAccount>',
        topic_name: :String,
        history_disclosed: :BOOLEAN,
        locale: :String,
        text: :String,
        summary: :String,
        attachments: :'Array<Attachment>',
        entities: :'Array<Entity>',
        channel_data: :Object,
        action: :String,
        reply_to_id: :String
      }
    end

    def reply(message)
      return false if type != 'message'
      new_activity = Activity.new(type: 'message',
                                  locale: 'en',
                                  text: message,
                                  from: recipient.as_json)
      Conversation.new(service_url).reply_to_activity(conversation.id, id, new_activity)
    end
  end
end
