module BotFramework
  # Supplementary parameter for media events
  class MediaEventValue < Base
    # Callback parameter specified in the Value field of the MediaCard that originated this event
    attr_accessor :card_value

    # Attribute type mapping.
    def self.swagger_types
      {
        card_value: :Object
      }
    end
  end
end
