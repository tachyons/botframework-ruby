require 'spec_helper'

describe BotFramework::Bot do
  subject(:bot) { described_class }

  let(:hook) { proc { |_args| } }

  it '.add_recognizer' do
    expect(described_class.recognizers).to be_empty
    recognizer = instance_double('recognizer')
    described_class.add_recognizer(recognizer)
    expect(described_class.recognizers).to eq([recognizer])
  end

  it 'register event callback' do
    bot.on('created', &hook)
    expect(bot.hooks['created']).to be_eql(hook)
  end

  it 'register intent callback' do
    bot.on_intent('get_name', &hook)
    expect(bot.intent_callbacks['get_name']).to be_eql(hook)
  end

  describe '.trigger' do
    let(:hook) { proc { |args| args } }

    it 'returns false when event is not registered' do
      expect(bot.trigger('created')).to be_falsy
    end

    it 'execute the hook if the event is already registered' do
      response = instance_spy('response')
      hook = proc { response }
      bot.on('created', &hook)
      expect(bot.trigger('created')).to be_eql(response)
    end
  end
end
