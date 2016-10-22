require 'oauth2'
require 'jwt'
require 'httparty'
require 'json'
require 'bot_framework/version'
require 'bot_framework/errors'
require 'bot_framework/util'
require 'bot_framework/connector'
require 'bot_framework/api_base'
require 'bot_framework/conversation'
require 'bot_framework/bot_state'
require 'bot_framework/token_validator'
require 'bot_framework/bot'
require 'bot_framework/server'
require 'bot_framework/models/base'
require 'bot_framework/models/activity'
require 'bot_framework/models/api_response'
require 'bot_framework/models/attachment'
require 'bot_framework/models/attachment_data'
require 'bot_framework/models/attachment_info'
require 'bot_framework/models/attachment_view'
require 'bot_framework/models/bot_data'
require 'bot_framework/models/card_action'
require 'bot_framework/models/card_image'
require 'bot_framework/models/channel_account'
require 'bot_framework/models/conversation_account'
require 'bot_framework/models/conversation_parameters'
require 'bot_framework/models/entity'
require 'bot_framework/models/fact'
require 'bot_framework/models/geo_coordinates'
require 'bot_framework/models/hero_card'
require 'bot_framework/models/object'
require 'bot_framework/models/place'
require 'bot_framework/models/receipt_card'
require 'bot_framework/models/receipt_item'
require 'bot_framework/models/resource_response'
require 'bot_framework/models/signin_card'
require 'bot_framework/models/thumbnail_card'

module BotFramework
  class << self
    attr_accessor :connector

    def configure(*args, &block)
      @connector = Connector.new(*args, &block)
    end
  end
end
