require 'uri'

module BotFramework
  class TokenValidator
    include HTTParty
    attr_accessor :headers, :errors

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
      JSON.parse(self.class.get(Connector::OPEN_ID_METADATA).body)
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
      (condition = auth_header) && auth_header.start_with?('Bearer')
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
      iss = JWT.decode(token, nil, false).first['iss']
      begin
        uri = URI.parse(iss)
      rescue URI::InvalidURIError
        return false
      end

      condition = uri.scheme == 'https' && Connector::ISSUER_DOMAINS.include?(uri.host.downcase)
      errors << "Invalid iss #{iss}" unless condition
      condition
    end

    def valid_audience?
      # The token contains an audience claim with a value equivalent to your bot’s Microsoft App ID.
      aud = JWT.decode(token, nil, false).first['aud']
      condition = ['https://graph.microsoft.com', BotFramework.connector.app_id].include?(aud)
      errors << "Invalid audience #{aud}" unless condition
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
