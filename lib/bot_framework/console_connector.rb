require 'observer'
require 'nio'
module BotFramework
  class ConsoleConnector
    include Observable
    def listen
      p 'Listening'
      loop do
        line = Readline.readline('> ')
        break if line.nil? || line == 'quit'
        Readline::HISTORY.push(line)
        puts "You typed: #{line}"
      end
      self
    end
  end
end
