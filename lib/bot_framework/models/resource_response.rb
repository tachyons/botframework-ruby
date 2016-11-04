module BotFramework
  class ResourceResponse < Base
    # Id of the resource
    attr_accessor :id

    # Attribute type mapping.
    def self.swagger_types
      {
        id: :String
      }
    end
  end
end
