module BotFramework
  class CardAction < Base
    # Defines the type of action implemented by this button.
    attr_accessor :type

    # Text description which appear on the button.
    attr_accessor :title

    # URL Picture which will appear on the button, next to text label.
    attr_accessor :image

    # Supplementary parameter for action. Content of this property depends on the ActionType
    attr_accessor :value

    # Attribute mapping from ruby-style variable name to JSON key.
    # Attribute type mapping.
    def self.swagger_types
      {
        type: :String,
        title: :String,
        image: :String,
        value: :String
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.type = attributes[:type] if attributes.key?(:type)

      self.title = attributes[:title] if attributes.key?(:title)

      self.image = attributes[:image] if attributes.key?(:image)

      self.value = attributes[:value] if attributes.key?(:value)
    end
  end
end
