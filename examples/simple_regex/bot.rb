BotFramework.configure do |connector|
  connector.app_id = ENV['RUBY_CONF_MICROSOFT_APP_ID']
  connector.app_secret = ENV['RUBY_CONF_MICROSOFT_APP_PASSWORD']
end

BotFramework::Bot.add_recognizer(BotFramework::Dialogs::RegExpRecognizer.new('HelpIntent', /^(help|options)/i))
BotFramework::Bot.add_recognizer(BotFramework::Dialogs::RegExpRecognizer.new('HelloIntent', /^(hi|hello|hai)/i))

BotFramework::Bot.on :activity do |activity|
  # All activities
end

BotFramework::Bot.on :message do |activity|
  # Call back for messages
end

BotFramework::Bot.on :ping do |activity|
  # Callback for pings
end

BotFramework::Bot.on :typing do |activity|
  # Callback for typing
end

BotFramework::Bot.on_intent 'HelpIntent' do |activity, _intents|
  reply(activity, "<HELP TEXT HERE>")
end

BotFramework::Bot.on_intent 'HelloIntent' do |activity, _intents|
  reply(activity, "Hello")
end

BotFramework::Bot.on_intent :default do |activity, _intents|
  reply(activity, 'Unable to recognize')
end
