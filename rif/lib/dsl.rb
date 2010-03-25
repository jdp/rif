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

    def room_helper(name, &block)
      Rif::Room.send(:define_method, name, block)
    end

    def command(name, &block)
      Rif::Commands.send(:define_method, name, block)
    end
  end
end