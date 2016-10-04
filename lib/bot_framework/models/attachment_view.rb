module BotFramework
  # Attachment View name and size
  class AttachmentView < Base
    # content type of the attachmnet
    attr_accessor :view_id

    # Name of the attachment
    attr_accessor :size

    # Attribute type mapping.
    def self.swagger_types
      {
        view_id: :String,
        size: :Integer
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.view_id = attributes[:viewId] if attributes.key?(:viewId)

      self.size = attributes[:size] if attributes.key?(:size)
    end
  end
end
