require 'spec_helper'
require 'timecop'
require './lib/bot_framework/dialogs/entity_recognizer.rb'

RSpec.describe BotFramework::Dialogs::EntityRecognizer do
  describe '.recognize_time' do
    before do
      Timecop.freeze(Time.utc(2018))
    end

    it 'returns parsed time' do
      expect(described_class.recognize_time('yesterday')).to be_eql(entity: '2017-12-31 12:00:00 +0530',
                                                                    resolution: {
                                                                      resolution_type: 'chronic.time',
                                                                      time: Time.parse('2017-12-31 12:00:00.000000000 +0530')
                                                                    },
                                                                    type: 'chronic.time')
    end
  end

  describe '.parse_number' do
    it 'parse number from a string' do
      expect(described_class.parse_number('an apple and 10 oranges')).to be_eql('10')
    end
  end

  describe '.parse_boolean' do
    it 'return true for positive responses' do
      %w[yes Yeah sure Ok].each do |response|
        expect(described_class.parse_boolean(response)).to be_eql(true)
      end
    end

    it 'returns false for negative responses' do
      %w[No never nope not false].each do |response|
        expect(described_class.parse_boolean(response)).to be_eql(false)
      end
    end

    it 'returns nil for neutral response' do
      %w[maybe vayad].each do |response|
        expect(described_class.parse_boolean(response)).to be_nil
      end
    end
  end
end
