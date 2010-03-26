require 'readline'

module Rif
  class Runner
    
    def initialize(game)
      @game = game
      @game.freeze
    end
    
    def restart!
      @state    = State.new(@game)
      @commands = Commands.new(@game, @state)
      @parser   = Parser.new(@commands)
    end

    def read_line
      line = Readline::readline('> ').strip
      return false if line.empty?
      Readline::HISTORY.push(line)
      line
    end

    def write_line(line)
      puts line
    end
    
    def run!
      restart!
      @state.room do |r|
        r.say r.trigger_event(:look)
        r.say r.trigger_event(:enter)
        write_line r.messages
        r.reset!
      end
      while cmd = read_line
        break if cmd == 'quit'
        @parser.parse_and_run(cmd) do |o|
          write_line o
        end
        @state.room.reset!
      end
    end
    
  end
end