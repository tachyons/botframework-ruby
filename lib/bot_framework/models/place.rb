module BotFramework
  # Place (entity type: \"https://schema.org/Place\")
  class Place < Base
    # Address of the place (may be `string` or complex object of type `PostalAddress`)
    attr_accessor :address

    # Geo coordinates of the place (may be complex object of type `GeoCoordinates` or `GeoShape`)
    attr_accessor :geo

    # Map to the place (may be `string` (URL) or complex object of type `Map`)
    attr_accessor :has_map

    # The type of the thing
    attr_accessor :type

    # The name of the thing
    attr_accessor :name

    # Attribute type mapping.
    def self.swagger_types
      {
        address: :Object,
        geo: :Object,
        has_map: :Object,
        type: :String,
        name: :String
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.address = attributes[:address] if attributes.key?(:address)

      self.geo = attributes[:geo] if attributes.key?(:geo)

      self.has_map = attributes[:hasMap] if attributes.key?(:hasMap)

      self.type = attributes[:type] if attributes.key?(:type)

      self.name = attributes[:name] if attributes.key?(:name)
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properies with the reasons
    def list_invalid_properties
      invalid_properties = []
      invalid_properties
    end
  end
end
