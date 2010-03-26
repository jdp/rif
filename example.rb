require 'rif/rif'

room_helpers do
  
  attr_accessor :monster
  
  def add_monster name
    @monster = { :name => name }
  end
  
  def has_monster
    ! @monster.nil?
  end

end

commands do

  def attack
    if state.room.has_monster
      state.room do |r|
        r.say "Attacking the #{r.monster[:name]}"
        r.say r.trigger_event(:monster_attacked)
      end
      state.room.messages
    else
      "Nothing to attack"
    end
  end
  
end

room :bedroom do |r|
  r.name 'Bedroom'
  r.describe "This is the description of the bedroom"
  r.add_monster :chizpurfle
  r.on_enter do
    if r.has_monster
      "There is a #{r.monster[:name]} lurking here"
    end
  end
  r.on_monster_attacked do
    "The #{r.monster[:name]} retaliates!"
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