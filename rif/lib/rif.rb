
THE_GAME = Rif::Game.new

def game
  THE_GAME
end

def room(room_id)
  room = Rif::Room.new(room_id)
  game.add_room(room.id, room)
  yield room if block_given?
  room
end