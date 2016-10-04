module BotFramework
  class CardImage < Base
    # URL Thumbnail image for major content property.
    attr_accessor :url

    # Image description intended for screen readers
    attr_accessor :alt

    # Action assigned to specific Attachment.E.g.navigate to specific URL or play/open media content
    attr_accessor :tap

    # Attribute type mapping.
    def self.swagger_types
      {
        url: :String,
        alt: :String,
        tap: :CardAction
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.url = attributes[:url] if attributes.key?(:url)

      self.alt = attributes[:alt] if attributes.key?(:alt)

      self.tap = attributes[:tap] if attributes.key?(:tap)
    end
  end
end
