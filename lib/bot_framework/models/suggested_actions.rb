module BotFramework
  # SuggestedActions that can be performed
  class SuggestedActions
    # Ids of the recipients that the actions should be shown to.  These Ids are relative to the channelId and a subset of all recipients of the activity
    attr_accessor :to

    # Actions that can be shown to the user
    attr_accessor :actions

    # Attribute type mapping.
    def self.swagger_types
      {
        to: :'Array<String>',
        actions: :'Array<CardAction>'
      }
    end
  end
end
