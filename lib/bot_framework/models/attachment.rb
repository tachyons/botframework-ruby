module BotFramework
  class Attachment < Base
    # mimetype/Contenttype for the file
    attr_accessor :content_type

    # Content Url
    attr_accessor :content_url

    # Embedded content
    attr_accessor :content

    # (OPTIONAL) The name of the attachment
    attr_accessor :name

    # (OPTIONAL) Thumbnail associated with attachment
    attr_accessor :thumbnail_url

    # Attribute type mapping.
    def self.swagger_types
      {
        content_type: :String,
        content_url: :String,
        content: :Object,
        name: :String,
        thumbnail_url: :String
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # def initialize(attributes = {})
    #   return unless attributes.is_a?(Hash)
    #
    #   # convert string to symbol for hash key
    #   attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }
    #
    #   if attributes.key?(:contentType)
    #     self.content_type = attributes[:contentType]
    #   end
    #
    #   self.content_url = attributes[:contentUrl] if attributes.key?(:contentUrl)
    #
    #   self.content = attributes[:content] if attributes.key?(:content)
    #
    #   self.name = attributes[:name] if attributes.key?(:name)
    #
    #   if attributes.key?(:thumbnailUrl)
    #     self.thumbnail_url = attributes[:thumbnailUrl]
    #   end
    # end
  end
end
