module BotFramework
  class Message
    TEXT_FORMAT = {
      plain: 'plain',
      markdown: 'markdown',
      xml: 'xml'
    }.freeze
    ATTACHMENT_LAYOUT = {
      list: 'list',
      carousel: 'carousel'
    }.freeze

    def initialize(_session = nil)
      @data = {}
      @data[:type] = 'consts.MessageType' # FIXME
      @data[:agent] = 'consts.agent'
      if @session
        m = @session.message
        @data[:source] = m[:source] if m[:source]
        @data[:text_locale] = m[:text_locale] if m[:text_locale]
        @data[:address] = m[:address] if m[:address]
      end
    end

    def text_locale(locale)
      @data[:text_locale] = locale
      self
    end

    def text_format(style)
      @data[:text_format] = style
      self
    end

    def text(text, *_args)
      @data[:text] = text.present? ? format_text(text) : ''
      self
    end

    def ntext(msg, _msg_plural, count)
      fmt = count == 1 ? self.class.random_prompt(msg) : self.class.random_prmpt(message_plural)
      fmt = @session.get_text(fmt) if @session
      @data[:text] = fmt, count # FIXME
      self
    end

    def compose(prompts, *args)
      if prompts
        @data[:text] = Message.compose_prompt(@session, prompts, *args)
        self
      end
    end

    def summary; end

    def attachment_layout; end

    def attachments; end

    def add_attachment; end

    def entities; end

    def add_entity; end

    def address; end

    def timestamp; end

    def source_event; end

    def to_message; end

    class << self
      def random_prompt; end

      def compose_prompt; end
    end
  end
end
