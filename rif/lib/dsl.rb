module Rif
  module DSL
    THE_GAME = Rif::Game.new

    def game
      THE_GAME
    end

    def room room_id
      room = Rif::Room.new(room_id)
      game.add_room(room)
      yield room if block_given?
      room
    end

    def room_helpers(&block)
      Rif::Room.class_eval(&block)
    end

    def commands(&block)
      Rif::Commands.class_eval(&block)
    end
  end
end