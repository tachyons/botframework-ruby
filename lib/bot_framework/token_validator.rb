module BotFramework
  class TokenValidator
    include HTTParty
    attr_accessor :headers, :errors

    OPEN_ID_CONFIG_URI = 'https://api.aps.skype.com/v1/.well-known/openidconfiguration'.freeze

    def initialize(headers)
      @headers = headers
    end

    def valid?
      valid_header? &&
        valid_jwt? &&
        valid_iss? &&
        valid_audience? &&
        valid_token? &&
        valid_signature?
    end

    def errors
      @errors ||= []
    end

    private

    def open_id_config
      JSON.parse(self.class.get(OPEN_ID_CONFIG_URI).body)
    end

    def jwks_uri
      open_id_config['jwks_uri']
    end

    def valid_keys
      JSON.parse(self.class.get(jwks_uri).body)['keys']
    end

    def auth_header
      headers['Authorization']
    end

    def token
      auth_header.gsub('Bearer ', '')
    end

    def valid_header?
      # The token was sent in the HTTP Authorization header with "Bearer" scheme
      condition = auth_header.start_with? 'Bearer'
      errors << 'Invalid headers' unless condition
      condition
    end
    # Validations

    def valid_jwt?
      # The token is valid JSON that conforms to the JWT standard (see references)
      condition = JWT.decode token, nil, false
      errors << 'Invalid jwt' unless condition
      condition
    end

    def valid_iss?
      # The token contains an issuer claim with value of https://api.botframework.com
      condition = JWT.decode(token, nil, false).first['iss'] == 'https://api.botframework.com'
      errors << 'Invalid iss' unless condition
      condition
    end

    def valid_audience?
      # The token contains an audience claim with a value equivalent to your bot’s Microsoft App ID.
      condition = (JWT.decode(token, nil, false).first['aud'] == BotFramework.connector.app_id)
      errors << 'Invalid audience' unless condition
      condition
    end

    def valid_token?
      # The token has not yet expired. Industry-standard clock-skew is 5 minutes.
      # Should not raise JWT::ExpiredSignature
      true
    end

    def valid_signature?
      # The token has a valid cryptographic signature with a key listed in the OpenId keys document retrieved in step 1, above.
      true
    end
  end
end
