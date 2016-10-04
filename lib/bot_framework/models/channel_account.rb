module BotFramework
  # Channel account information needed to route a message
  class ChannelAccount < Base
    # Channel id for the user or bot on this channel (Example: joe@smith.com, or @joesmith or 123456)
    attr_accessor :id

    # Display friendly name
    attr_accessor :name

    # Attribute type mapping.
    def self.swagger_types
      {
        id: :String,
        name: :String
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.id = attributes[:id] if attributes.key?(:id)

      self.name = attributes[:name] if attributes.key?(:name)
    end
  end
end
