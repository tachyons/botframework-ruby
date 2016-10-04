
module BotFramework
  # Object of schema.org types
  class Entity < Base
    # Entity Type (typically from schema.org types)
    attr_accessor :type

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        type: :type
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        type: :String
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.type = attributes[:type] if attributes.key?(:type)
    end
  end
end
