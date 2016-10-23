module BotFramework
  class Server
    def self.call(env)
      new.call(env)
    end

    def call(env)
      @request = Rack::Request.new env
      @response = Rack::Response.new
      if @request.post?
        if verify
          receive
        else
          p "Errors"
          p TokenValidator.new(headers).errors.join(",")
          raise InvalidToken
        end
      end
      @response.finish
    end

    # TODO: reply in separate thread t avoid timeout
    def receive
      # Thread.new {
      activity = Activity.new.build_from_hash JSON.parse(@request.body.read)
      Bot.receive(activity)
      # }
    end

    def headers
      env = @request.env
      Hash[*env.select { |k, _v| k.start_with? 'HTTP_' }
               .collect { |k, v| [k.sub(/^HTTP_/, ''), v] }
               .collect { |k, v| [k.split('_').collect(&:capitalize).join('-'), v] }
           .sort
           .flatten]
    end

    def verify
      TokenValidator.new(headers).valid?
    rescue JWT::DecodeError
      [401, { 'Content-Type' => 'text/plain' }, ['A token must be passed.']]
    rescue JWT::ExpiredSignature
      [403, { 'Content-Type' => 'text/plain' }, ['The token has expired.']]
    rescue JWT::InvalidIssuerError
      [403, { 'Content-Type' => 'text/plain' }, ['The token does not have a valid issuer.']]
    rescue JWT::InvalidIatError
      [403, { 'Content-Type' => 'text/plain' }, ['The token does not have a valid "issued at" time.']]
    end
  end
end
