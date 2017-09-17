module BotFramework
  class CardAction < Base
    # Defines the type of action implemented by this button.
    attr_accessor :type

    # Text description which appear on the button.
    attr_accessor :title

    # URL Picture which will appear on the button, next to text label.
    attr_accessor :image
    # Text for this action

    attr_accessor :text

    # (Optional) text to display in the chat feed if the button is clicked
    attr_accessor :display_text

    # Supplementary parameter for action. Content of this property depends on the ActionType
    attr_accessor :value

    # Attribute mapping from ruby-style variable name to JSON key.
    # Attribute type mapping.
    def self.swagger_types
      {
        type: :String,
        title: :String,
        image: :String,
        text:  :String,
        display_text: :String,
        value: :String
      }
    end
  end
end
