module Rif
  class Game

    attr_reader :rooms
  
    def initialize
      @rooms = {}
    end

    def starting_room
      @rooms.find { |r| r.starting_room? }
    end

    def add_room(room)
      @rooms[room.id] = room
    end

  end
end