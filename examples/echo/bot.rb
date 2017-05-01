BotFramework.configure do |connector|
  connector.app_id = ENV['MICROSOFT_APP_ID']
  connector.app_secret = ENV['MICROSOFT_APP_SECRET']
end

BotFramework::Bot.on :activity do |activity|
  conversation_data(activity)
  reply(activity, activity.text)
end
