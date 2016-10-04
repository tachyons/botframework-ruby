module BotFramework
  # GeoCoordinates (entity type: \"https://schema.org/GeoCoordinates\")
  class GeoCoordinates < Base
    # Elevation of the location [WGS 84](https://en.wikipedia.org/wiki/World_Geodetic_System)
    attr_accessor :elevation

    # Latitude of the location [WGS 84](https://en.wikipedia.org/wiki/World_Geodetic_System)
    attr_accessor :latitude

    # Longitude of the location [WGS 84](https://en.wikipedia.org/wiki/World_Geodetic_System)
    attr_accessor :longitude

    # The type of the thing
    attr_accessor :type

    # The name of the thing
    attr_accessor :name

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        elevation: :elevation,
        latitude: :latitude,
        longitude: :longitude,
        type: :type,
        name: :name
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        elevation: :Float,
        latitude: :Float,
        longitude: :Float,
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

      self.elevation = attributes[:elevation] if attributes.key?(:elevation)

      self.latitude = attributes[:latitude] if attributes.key?(:latitude)

      self.longitude = attributes[:longitude] if attributes.key?(:longitude)

      self.type = attributes[:type] if attributes.key?(:type)

      self.name = attributes[:name] if attributes.key?(:name)
    end
  end
end
