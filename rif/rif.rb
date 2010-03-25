%w(
  room
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
end

# Expose the DSL
include Rif::DSL

at_exit do
  raise $! if $!
  Rif::Runner.new(game).run!
end