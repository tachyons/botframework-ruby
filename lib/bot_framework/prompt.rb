module BotFramework
  class Prompt < Dialog
    @@options = {
      recognizer: BotFramework::SimplePromptRecognizer.new,
      prompt_after_action: true
    }

    @@default_retry_prompt = {
      text: 'default_text',
      number: 'default_number',
      confirm: 'daefault_confirm',
      choice: 'default_choice',
      time: 'default_time',
      attachment: 'default_file'
    }

    def self.configure(_options); end

    def begin(session, options = {})
      options[:prompt_after_action] = options[:prompt_after_action] || options[:prompt_after_action]
      options[:retry_count] = 0
      options.each do |option|
        # Store in dialog data
      end
      send_prompt(session, options)
    end

    def reply_received(session, args = {}); end

    def dialog_resumed; end

    def recognize; end

    def send_prompt(session, options); end

    def create_prompt; end

    def self.text; end

    def self.number; end

    def self.confirm; end

    def self.choice; end

    def self.time; end

    def self.attachment; end

    def self.disambiguate; end

    private
  end
end
