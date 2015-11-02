require 'optparse'

module LectorsProber
  class Parser
    def initialize(args)
      @args = args.dup
    end

    def parse
      OptionParser.new do |opts|
        opts.banner = 'Usage: ./demo.rb num_group'
      end.parse!(@args)
      @args.shift
    end
  end
end
