module Rif
  class Room

    def self.sanitise_id(id)
      id.to_s.strip.to_sym
    end

    def initialize(id)
      @id = self.class.sanitise_id(id)
      @description = []
      @exits = {}
      @locals = {}
    end

    def id
      @id
    end

    def name(name = nil)
      @name = name unless name.nil?
      @name
    end

    def on_visit(&block)
      @on_visit = block
    end

    def describe(prose)
      @description << prose
    end

    def description
      @description.empty? ? "None" : @description.join("\n")
    end

    def set(name, value)
      @locals[name.to_sym] = value
    end

    def method_missing(name, *args)
      if name.to_s[-1,1] == "="
        @locals[name.to_s[0..-2].strip.to_sym] = args[0]
      end
      @locals[name]
    end

    %w(north south east west).each do |dir|
      dir = dir.to_sym
      define_method(dir) do |r|
        @exits[dir] = r
      end
    end

    def exits(exits = nil)
      unless exits.nil?
        @exits.merge!(exits)
      end
      @exits
    end

    def start_here
      @starting_room = true
    end

    def starting_room?
      !! @starting_room
    end

    def visit
      @description = @description[0,1]
      @on_visit.call unless @on_visit.nil?
      description
    end
  end
end