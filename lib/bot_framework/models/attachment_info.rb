module BotFramework
  # Metdata for an attachment
  class AttachmentInfo < Base
    # Name of the attachment
    attr_accessor :name

    # ContentType of the attachment
    attr_accessor :type

    # attachment views
    attr_accessor :views

    # Attribute type mapping.
    def self.swagger_types
      {
        name: :String,
        type: :String,
        views: :'Array<AttachmentView>'
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.name = attributes[:name] if attributes.key?(:name)

      self.type = attributes[:type] if attributes.key?(:type)

      if attributes.key?(:views)
        if (value = attributes[:views]).is_a?(Array)
          self.views = value
        end
      end
    end
  end
end
