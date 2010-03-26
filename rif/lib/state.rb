module Rif
  class State
    attr_reader :turns
    attr_writer :room
   
    def initialize(game)
      @game   = game
      @turns  = 0
      @room   = @game.rooms.values.find { |r| r.starting_room? }
    end
    
    def turn!
      @turns += 1
    end

    def room
      yield @room if block_given?
      @room
    end
  end
end