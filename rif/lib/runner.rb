require 'readline'

module Rif
  class Runner
    include Readline
    
    def initialize(game)
      @game = game
      @game.freeze
    end
    
    def restart!
      @state    = State.new(@game)
      @commands = Commands.new(@game, @state)
      @parser   = Parser.new(@commands)
    end
    
    def run!
      restart!
      puts @state.room.trigger_event :visit
      while cmd = readline('> ')
        break if cmd == 'quit'
        @parser.parse_and_run(cmd)
      end
    end

    class << self
      def game
        @game
      end
    end
    
  end
end