module BotFramework
  class ApiBase
    include HTTParty
    attr_accessor :service_url

    def initialize(service_url)
      @service_url = service_url
    end

    def api_get(local_uri, _opts = {})
      uri = service_url + local_uri
      JSON.parse BotFramework.connector.token.get(uri)
    end

    def api_post(local_uri, opts = {})
      uri = service_url + local_uri
      JSON.parse BotFramework.connector.token.post(uri, body: opts.to_json,
                                             headers: { 'Content-Type' => 'application/json' })
    end

    def api_delete(local_uri)
      uri = service_url + local_uri
      BotFramework.connector.token.delete(uri)
    end

    def api_request(method,local_uri,opts)
      uri = service_url + local_uri
      BotFramework.connector.token.request(method,uri,opts)
    end
  end
end
