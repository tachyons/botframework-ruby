module BotFramework
  class HeroCard < Base
    # Title of the card
    attr_accessor :title

    # Subtitle of the card
    attr_accessor :subtitle

    # Text for the card
    attr_accessor :text

    # Array of i
    attr_accessor :images

    # Set of actions applicable to the current card
    attr_accessor :buttons

    # This action will be activated when user taps on the card itself
    attr_accessor :tap

    # Attribute type mapping.
    def self.swagger_types
      {
        title: :String,
        subtitle: :String,
        text: :String,
        images: :'Array<CardImage>',
        buttons: :'Array<CardAction>',
        tap: :CardAction
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    #   def initialize(attributes = {})
    #     return unless attributes.is_a?(Hash)
    #
    #     # convert string to symbol for hash key
    #     attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }
    #
    #     self.title = attributes[:title] if attributes.key?(:title)
    #
    #     self.subtitle = attributes[:subtitle] if attributes.key?(:subtitle)
    #
    #     self.text = attributes[:text] if attributes.key?(:text)
    #
    #     if attributes.key?(:images)
    #       if (value = attributes[:images]).is_a?(Array)
    #         self.images = value
    #       end
    #     end
    #
    #     if attributes.key?(:buttons)
    #       if (value = attributes[:buttons]).is_a?(Array)
    #         self.buttons = value
    #       end
    #     end
    #
    #     self.tap = attributes[:tap] if attributes.key?(:tap)
    #   end
  end
end
