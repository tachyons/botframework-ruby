module BotFramework
  class APIResponse < Base
    attr_accessor :message

    # Attribute type mapping.
    def self.swagger_types
      {
        message: :String
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.message = attributes[:message] if attributes.key?(:message)
    end
  end
end
