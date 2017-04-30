require 'observer'
require 'nio'
module BotFramework
  class ConsoleConnector
    include Observable
    def listen
      BotFramework.logger.info 'Listening'
      loop do
        line = Readline.readline('> ')
        break if line.nil? || line == 'quit'
        Readline::HISTORY.push(line)
        BotFramework.logger.info "You typed: #{line}"
      end
      self
    end
  end
end
