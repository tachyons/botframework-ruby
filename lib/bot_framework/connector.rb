module BotFramework
  # Connector class
  class Connector
    # include HTTParty
    attr_accessor :app_id, :app_secret, :token
    CONFIG_URI = 'https://api.aps.skype.com/v1/.well-known/openidconfiguration'.freeze

    def initialize(options = {})
      @app_id = options[:app_id]
      @app_secret = options[:app_secret]
      yield(self) if block_given?
    end

    def client
      OAuth2::Client.new(app_id, app_secret,
                         authorize_url: '/common/oauth2/v2.0/authorize',
                         token_url: '/common/oauth2/v2.0/token',
                         raise_errors: true,
                         site: 'https://login.microsoftonline.com')
    end

    def token
      @token = nil if @token && @token.expired?
      @token ||= get_token
      @token
    end

    def get_token
      client.client_credentials.get_token(scope: 'https://graph.microsoft.com/.default',
                                          client_id: app_id,
                                          client_secret: app_secret)
    end
  end
end
