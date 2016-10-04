module BotFramework
  # Set of key-value pairs. Advantage of this section is that key and value properties will be               rendered with default style information with some delimiter between them. So there is no need for developer to specify style information.
  class Fact < Base
    attr_accessor :key

    attr_accessor :value

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        key: :key,
        value: :value
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        key: :String,
        value: :String
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.key = attributes[:key] if attributes.key?(:key)

      self.value = attributes[:value] if attributes.key?(:value)
    end
  end
end
