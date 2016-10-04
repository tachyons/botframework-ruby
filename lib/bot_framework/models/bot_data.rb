module BotFramework
  class BotData < Base
    attr_accessor :data

    attr_accessor :e_tag

    # Attribute type mapping.
    def self.swagger_types
      {
        data: :Object,
        e_tag: :String
      }
    end
  end
end
