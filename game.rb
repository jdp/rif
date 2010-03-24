require 'rif/rif'

room :bedroom do |r|
  r.name 'Bedroom'
  r.describe "This is the description of the bedroom"
  r.on_visit do
    r.turns ||= 0
    r.turns += 1
    r.describe "I'm in the bedroom! #{r.turns}!"
  end
  r.north :hallway
  r.start_here
end

room :hallway do |r|
  r.name 'Hallway'
  r.describe "This is the description of the hallway"
  r.on_visit do
    r.turns ||= 0
    r.describe "It is turn #{@turns}"
  end
  r.exits :south => :bedroom, :east => :kitchen
end

room :kitchen do |r|
  r.name 'Kitchen'
  r.describe "This kitchen is grubby! Pots and pans everywhere!"
  r.west :hallway
end