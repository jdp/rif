module Rif
  class Room

    attr_writer :description

    def self.sanitise_id(id)
      id.to_s.strip.to_sym
    end

    def initialize(id)
      @id = self.class.sanitise_id(id)
      @messages = []
      @events = {:look => Proc.new { description }}
      @exits = {:idle => @id}
      @locals = {}
      yield self if block_given?
    end

    def id
      @id
    end

    def name(name = nil)
      @name = name unless name.nil?
      @name
    end

    def add_event(name, block)
      @events[name] = block
    end

    def trigger_event(name)
      @events[name].call unless @events[name].nil?
    end

    def describe(prose)
      @description = prose
    end

    def description
      return "An empty room." if @description.nil?
      @description
    end

    def say(prose)
      @messages << prose
    end

    def messages
      @messages.join("\n")
    end

    def reset!
      @messages = []
    end

    def method_missing(name, *args, &block)
      if name.to_s[0,3] == "on_"
        add_event(name.to_s[3..-1].to_sym, block) if block_given?
      elsif name.to_s[-1,1] == "="
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

  end
end