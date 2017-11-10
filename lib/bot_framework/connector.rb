module BotFramework
  # Connector class
  class Connector
    # include HTTParty
    attr_accessor :app_id, :app_secret, :token
    CONFIG_URI = 'https://api.aps.skype.com/v1/.well-known/openidconfiguration'.freeze
    REFRESH_ENDPOINT = 'https://login.microsoftonline.com/botframework.com/oauth2/v2.0/token'.freeze
    REFRESH_SCOPE = 'https://api.botframework.com/.default'.freeze
    OPEN_ID_METADATA = 'https://login.botframework.com/v1/.well-known/openidconfiguration'.freeze
    BOT_CONNECTOR_ISSUER = 'https://api.botframework.com'.freeze
    MSA_OPEN_ID_METADATA = 'https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration'.freeze
    MSA_ISSUER = 'https://sts.windows.net/72f988bf-86f1-41af-91ab-2d7cd011db47/'.freeze
    MSA_AUDIENCE = 'https://graph.microsoft.com'.freeze
    EMULATOR_AUDIENCE_METADATA = 'https://login.microsoftonline.com/botframework.com/v2.0/.well-known/openid-configuration'.freeze
    EMULATOR_AUDIENCE = 'https://sts.windows.net/d6d49420-f39b-4df7-a1dc-d59a935871db/'.freeze
    STATE_END_POINT = 'https://state'.freeze
    ISSUER_DOMAINS = ['sts.windows.net', 'api.botframework.com', 'login.microsoftonline.com'].freeze

    def initialize(options = {})
      @app_id = options[:app_id]
      @app_secret = options[:app_secret]
      yield(self) if block_given?
    end

    def client
      OAuth2::Client.new(app_id, app_secret,
                         authorize_url: 'botframework.com/oauth2/v2.0/authorize',
                         token_url: 'botframework.com/oauth2/v2.0/token',
                         raise_errors: true,
                         site: 'https://login.microsoftonline.com')
    end

    def token
      @token = nil if @token && @token.expired?
      @token ||= get_token
      @token
    end

    def get_token
      client.client_credentials.get_token(scope: 'https://api.botframework.com/.default', token_method: :post)
    end
  end
end
