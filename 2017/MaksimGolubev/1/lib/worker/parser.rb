require 'optparse'

module Gardener
  class Parser
    def initialize(args)
      @args = args.dup
    end

    def parse
      OptionParser.new do |opts|
        opts.banner = 'Usage: ./demo.rb NAME'
      end.parse!(@args)
    end
  end
end
