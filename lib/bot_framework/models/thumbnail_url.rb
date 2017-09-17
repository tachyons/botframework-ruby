module BotFramework
  # Object describing a media thumbnail
  class ThumbnailUrl < Base
    # url pointing to an thumbnail to use for media content
    attr_accessor :url

    # Alt text to display for screen readers on the thumbnail image
    attr_accessor :alt

    # Attribute type mapping.
    def self.swagger_types
      {
        url: :String,
        alt: :String
      }
    end
  end
end
