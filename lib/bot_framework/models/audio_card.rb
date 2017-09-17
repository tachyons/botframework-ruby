module BotFramework
  # A audio card
  class AudioCard < Base
    # Aspect ratio of thumbnail/media placeholder, allowed values are \"16x9\" and \"9x16\"
    attr_accessor :aspect

    # Title of the card
    attr_accessor :title

    # Subtitle of the card
    attr_accessor :subtitle

    # Text of the card
    attr_accessor :text

    # Thumbnail placeholder
    attr_accessor :image

    # Array of media Url objects
    attr_accessor :media

    # Set of actions applicable to the current card
    attr_accessor :buttons

    # Is it OK for this content to be shareable with others (default:true)
    attr_accessor :shareable

    # Should the client loop playback at end of content (default:true)
    attr_accessor :autoloop

    # Should the client automatically start playback of video in this card (default:true)
    attr_accessor :autostart

    # Supplementary parameter for this card
    attr_accessor :value

    # Attribute type mapping.
    def self.swagger_types
      {
        aspect: :String,
        title: :String,
        subtitle: :String,
        text: :String,
        image: :ThumbnailUrl,
        media: :'Array<MediaUrl>',
        buttons: :'Array<CardAction>',
        shareable: :BOOLEAN,
        autoloop: :BOOLEAN,
        autostart: :BOOLEAN,
        value: :Object
      }
   end
  end
end
