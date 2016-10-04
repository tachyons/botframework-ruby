module BotFramework
  # Attachment data
  class AttachmentData < Base
    # content type of the attachmnet
    attr_accessor :type

    # Name of the attachment
    attr_accessor :name

    # original content
    attr_accessor :original_base64

    # Thumbnail
    attr_accessor :thumbnail_base64

    # Attribute type mapping.
    def self.swagger_types
      {
        type: :String,
        name: :String,
        original_base64: :String,
        thumbnail_base64: :String
      }
    end
  end
end
