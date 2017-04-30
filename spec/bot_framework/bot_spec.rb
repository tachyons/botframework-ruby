require 'spec_helper'

describe BotFramework::Bot do
  it '.add_recognizer' do
    expect(BotFramework::Bot.recognizers).to be_empty
    recognizer = double(:recognizer)
    BotFramework::Bot.add_recognizer(recognizer)
    expect(BotFramework::Bot.recognizers).to eq([recognizer])
  end
end
