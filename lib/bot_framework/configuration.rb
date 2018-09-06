module BotFramework
  class Configuration
    attr_writer :app_id, :app_secret

    def initialize
      @app_id = nil
      @app_secret = nil
    end

    def app_id
      raise Errors::Configuration, 'Bot Framework app_id missing! See the documentation for configuration settings.' unless @app_id
      @app_id
    end

    def app_secret
      raise Errors::Configuration, 'Bot Framework app_secret missing! See the documentation for configuration settings.' unless @app_secret
      @app_secret
    end

  end
end
