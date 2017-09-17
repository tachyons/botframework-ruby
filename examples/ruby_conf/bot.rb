
BotFramework.configure do |connector|
  connector.app_id = ENV['RUBY_CONF_MICROSOFT_APP_ID']
  connector.app_secret = ENV['RUBY_CONF_MICROSOFT_APP_PASSWORD']
end

SPEAKER_DATA = YAML.load_file('speaker_data.yaml')
RUBY_CONF_DATA = {
  'when' => 'Jan 27, 28, 29',
  'where' => 'Kochi',
  'venue' => 'Le Méridien Kochi',
  'organisers' => 'Emerging technology trust',
  'website' => 'http://rubyconfindia.org/'
}

BotFramework::Bot.recognizer = BotFramework::Dialogs::LuisRecognizer.new('https://westus.api.cognitive.microsoft.com/luis/v2.0/apps/f5104c51-8adc-4846-ba86-058ee25d88b2?subscription-key=d670862831e046c9bf1d8e9b0c485df2&q=')

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
def speaker_data(activity, entities, field)
  speaker = BotFramework::Dialogs::EntityRecognizer.find_entity(entities, 'speaker')
  speaker ||= conversation_data(activity)['speaker']
  if speaker && (SPEAKER_DATA[speaker[:entity]] || SPEAKER_DATA[speaker['entity']])
    set_conversation_data(activity, speaker: speaker)
    (SPEAKER_DATA[speaker[:entity]] || SPEAKER_DATA[speaker['entity']])[field]
  elsif speaker
    "Unable to find the speaker #{speaker[:entity]}"
  else
    'Could not find the speaker'
  end
end

BotFramework::Bot.on_intent 'speakerList' do |activity, _intents|
  reply(activity, SPEAKER_DATA.keys.map(&:capitalize).join(','))
end

BotFramework::Bot.on_intent 'speakerTopic' do |activity, intents|
  entities = intents[:entities]
  reply(activity, speaker_data(activity, entities, 'topic'))
end

BotFramework::Bot.on_intent 'speakerDescription' do |activity, intents|
  entities = intents[:entities]
  reply(activity, speaker_data(activity, entities, 'description'))
end

BotFramework::Bot.on_intent 'speakerTwitterHandle' do |activity, intents|
  entities = intents[:entities]
  reply(activity, speaker_data(activity, entities, 'twitter'))
end

BotFramework::Bot.on_intent 'speakerTalkTime' do |activity, intents|
  entities = intents[:entities]

  reply(activity, speaker_data(activity, entities, 'talk_date'))
end

BotFramework::Bot.on_intent 'eventSchedule' do |activity, intents|
  # entities = intents[:entities]
  # reply(activity, speaker_data(activity, entities,'talk_date'))
end

BotFramework::Bot.on_intent 'rubyconfDetails' do |activity, intents|
  entities = intents[:entities]
  detail = BotFramework::Dialogs::EntityRecognizer.find_entity(entities, 'eventDetailType')
  if detail && RUBY_CONF_DATA[detail[:entity]]
    reply(activity, RUBY_CONF_DATA[detail[:entity]])
  else
    reply(activity, "Sorry, I coudn't find that data")
  end
end

BotFramework::Bot.on_intent :default do |activity, _intents|
  reply(activity, 'Help text')
end
