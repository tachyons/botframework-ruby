module BotFramework
  # A card representing a request to signing
  class SigninCard < Base
    # Text for signin request
    attr_accessor :text

    # Action to use to perform signin
    attr_accessor :buttons

    # Attribute type mapping.
    def self.swagger_types
      {
        text: :String,
        buttons: :'Array<CardAction>'
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.text = attributes[:text] if attributes.key?(:text)

      if attributes.key?(:buttons)
        if (value = attributes[:buttons]).is_a?(Array)
          self.buttons = value
        end
      end
    end
  end
end
