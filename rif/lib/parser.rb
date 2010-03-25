module Rif
  class Parser
    def initialize(commands)
      @commands = commands
    end
    
    def parse_and_run(cmd)
      cmd.strip.split(/;/).each do |t|
        words = t.strip.split(/\s/)
        first = words[0]
        rest = words[1..-1]
        run(first, *rest)
      end
    end
    
    def run(cmd, *args)
      puts @commands.send(cmd.to_sym, *args)
    end
  end
end