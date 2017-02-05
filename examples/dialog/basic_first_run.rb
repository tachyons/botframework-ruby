require 'pry'
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bot_framework'
require 'bot_framework/console_connector'
require 'bot_framework/universal_bot'
# Setup bot and root message handler
include BotFramework

connector = ConsoleConnector.new.listen
bot = UniversalBot.new(connector, lambda do |session|
  session.send("You said #{session.message.text}")
end)
