require 'pry'
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bot_framework'
require_relative 'bot'
# include BotFramework
run BotFramework::Server
