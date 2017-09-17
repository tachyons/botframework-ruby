module BotFramework
  class ReceiptItem < Base
    # Title of the Card
    attr_accessor :title

    # Subtitle appears just below Title field, differs from Title in font styling only
    attr_accessor :subtitle

    # Text field appears just below subtitle, differs from Subtitle in font styling only
    attr_accessor :text

    # Image
    attr_accessor :image

    # Amount with currency
    attr_accessor :price

    # Number of items of given kind
    attr_accessor :quantity

    # This action will be activated when user taps on the Item bubble.
    attr_accessor :tap

    # Attribute type mapping.
    def self.swagger_types
      {
        title: :String,
        subtitle: :String,
        text: :String,
        image: :CardImage,
        price: :String,
        quantity: :String,
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
    #     self.image = attributes[:image] if attributes.key?(:image)
    #
    #     self.price = attributes[:price] if attributes.key?(:price)
    #
    #     self.quantity = attributes[:quantity] if attributes.key?(:quantity)
    #
    #     self.tap = attributes[:tap] if attributes.key?(:tap)
    #   end
  end
end
