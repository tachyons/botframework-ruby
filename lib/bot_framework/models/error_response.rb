module BotFramework
  # An HTTP API response
  class ErrorResponse < Base
    # Error message
    attr_accessor :error

    # Attribute type mapping.
    def self.swagger_types
      {
        error: :Error
      }
    end
  end
end
