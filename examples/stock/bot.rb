require 'luis'
require 'stock_quote'

BotFramework.configure do |connector|
  connector.app_id = ENV['MICROSOFT_APP_ID']
  connector.app_secret = ENV['MICROSOFT_APP_SECRET']
end
Luis.configure do |config|
  config.id = ENV['STOCK_LUIS_ID']
  config.subscription_key = ENV['STOCK_LUIS_KEY']
  # config.is_preview_mod = true
end

BotFramework::Bot.on :activity do |activity|
  luis_result = Luis.query(activity.text)
  if luis_result.intents.count > 0
    case luis_result.intents[0].intent
    when 'StockPrice'
      stock = luis_result.entities[0].entity
      stock_value = StockQuote::Stock.quote(stock).ask
      result = " Current stock value of #{stock} is #{stock_value}"
      set_conversation_data(activity, last_stock: stock)
    when 'RepeatLastStock'
      last_stock = get_conversation_data(activity)[:last_stock]
      if last_stock
        stock_value = StockQuote::Stock.quote(last_stock).ask
        result = " Current stock value of #{last_stock} is #{stock_value}"
      else
        result = 'No previous value available'
      end
    when 'None'
      result = "Sorry , I don't undersatnd"
    end
  else
    result = "Sorry, I don't understand"
  end
  reply(activity, result)
end
