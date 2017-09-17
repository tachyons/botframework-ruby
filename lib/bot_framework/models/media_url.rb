module BotFramework
  # MediaUrl data
  class MediaUrl < Base
    # Url for the media
    attr_accessor :url

    # Optional profile hint to the client to differentiate multiple MediaUrl objects from each other
    attr_accessor :profile

    # Attribute type mapping.
    def self.swagger_types
      {
        url: :String,
        profile: :String
      }
    end
  end
end
