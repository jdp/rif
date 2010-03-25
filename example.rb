require 'rif/rif'

room_helper :add_monster do |name|
  @monster = { :name => name }
end

room_helper :has_monster do
  ! @monster.nil?
end

room_helper :monster do
  @monster
end

command :attack do |style|
  if state.room.has_monster
    "Attacking the #{state.room.monster[:name]} in #{style}"
  else
    "Nothing to attack"
  end
end

room :bedroom do |r|
  r.name 'Bedroom'
  r.describe "This is the description of the bedroom"
  r.add_monster :chizpurfle
  r.on_visit do
    if r.has_monster
      r.describe "There is a #{r.monster[:name]} lurking here"
    end
  end
  r.north :hallway
  r.west :study
  r.start_here
end

room :hallway do |r|
  r.name 'Hallway'
  r.describe "This is the description of the hallway"
  r.exits :south => :bedroom, :east => :kitchen
end

room :kitchen do |r|
  r.name 'Kitchen'
  r.describe "This kitchen is grubby! Pots and pans everywhere!"
  r.west :hallway
end