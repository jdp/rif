%w(
  room
).each do |f|
  require File.join(File.dirname(__FILE__), 'lib', 'elements', f)
end

%w(
  game
  state
  commands
  parser
  runner
  dsl
).each do |f|
  require File.join(File.dirname(__FILE__), 'lib', f)
end

module Rif
  VERSION = 0.1
  
  def self.run(runner, game)
    runner.new(game).run!
  end
end

# Expose the DSL
include Rif::DSL

at_exit do
  raise $! if $!
  Rif.run Rif::Runner, game
end