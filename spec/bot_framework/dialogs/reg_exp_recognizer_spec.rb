require 'spec_helper'
module BotFramework
  module Dialogs
    describe RegExpRecognizer do
      it 'set attribute accessors' do
        recognizer = RegExpRecognizer.new('test', /test/)
        expect(recognizer.expressions).to eq('*': /test/)
        expect(recognizer.intent).to eq('test')
      end

      it '#recognize' do
        recognizer = RegExpRecognizer.new('test', /test/)
        expect { recognizer.recognize(message: { text: 'test' }) }.to raise_error(LocalJumpError)
      end
    end
  end
end
