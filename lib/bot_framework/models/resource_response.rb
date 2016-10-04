module BotFramework
  class ResourceResponse < Base
    # Id of the resource
    attr_accessor :id

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        id: :id
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        id: :String
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.id = attributes[:id] if attributes.key?(:id)
    end
  end
end
