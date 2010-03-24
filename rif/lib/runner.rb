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
      puts @state.room.visit
      while cmd = readline('> ')
        break if cmd == 'quit'
        @parser.parse_and_run(cmd)
      end
    end
    
  end
end

at_exit do
  raise $! if $!
  Rif::Runner.new(game).run!
end