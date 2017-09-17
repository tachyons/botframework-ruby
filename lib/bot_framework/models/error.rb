module BotFramework
  # Object representing error information
  class Error < Base
    # Error code
    attr_accessor :code

    # Error message
    attr_accessor :message

    # Attribute type mapping.
    def self.swagger_types
      {
        code: :String,
        message: :String
      }
    end
  end
end
