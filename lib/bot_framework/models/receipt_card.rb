module BotFramework
  class ReceiptCard < Base
    # Title of the card
    attr_accessor :title

    # Array of Receipt Items
    attr_accessor :items

    # Array of Fact Objects   Array of key-value pairs.
    attr_accessor :facts

    # This action will be activated when user taps on the card
    attr_accessor :tap

    # Total amount of money paid (or should be paid)
    attr_accessor :total

    # Total amount of TAX paid(or should be paid)
    attr_accessor :tax

    # Total amount of VAT paid(or should be paid)
    attr_accessor :vat

    # Set of actions applicable to the current card
    attr_accessor :buttons

    # Attribute type mapping.
    def self.swagger_types
      {
        title: :String,
        items: :'Array<ReceiptItem>',
        facts: :'Array<Fact>',
        tap: :CardAction,
        total: :String,
        tax: :String,
        vat: :String,
        buttons: :'Array<CardAction>'
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
    #   self.title = attributes[:title] if attributes.key?(:title)
    #
    #   if attributes.key?(:items)
    #     if (value = attributes[:items]).is_a?(Array)
    #       self.items = value
    #     end
    #   end
    #
    #   if attributes.key?(:facts)
    #     if (value = attributes[:facts]).is_a?(Array)
    #       self.facts = value
    #     end
    #   end
    #
    #   self.tap = attributes[:tap] if attributes.key?(:tap)
    #
    #   self.total = attributes[:total] if attributes.key?(:total)
    #
    #   self.tax = attributes[:tax] if attributes.key?(:tax)
    #
    #   self.vat = attributes[:vat] if attributes.key?(:vat)
    #
    #   if attributes.key?(:buttons)
    #     if (value = attributes[:buttons]).is_a?(Array)
    #       self.buttons = value
    #     end
    #   end
    # end
  end
end
