RSpec.describe BotFramework::Configuration do
  context 'with configuration block' do
    it 'returns correct app_id' do
      expect(BotFramework.configuration.app_id).to be_eql(ENV['BOT_FRAMEWORK_ACCESS'])
    end

    it 'returns correct app secret' do
      expect(BotFramework.configuration.app_secret).to be_eql(ENV['BOT_FRAMEWORK_SECRET'])
    end
  end

  context 'without config block' do
    before do
      BotFramework.reset
    end

    it 'returns correct app_id' do
      expect { BotFramework.configuration.app_id }.to raise_error(BotFramework::Errors::Configuration)
    end

    it 'returns correct app secret' do
      expect { BotFramework.configuration.app_secret }.to raise_error(BotFramework::Errors::Configuration)
    end
  end
end
