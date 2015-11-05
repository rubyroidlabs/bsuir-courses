require 'optparse'

module LectorsProber
  class ParserArgv
    def initialize(argv)
      @argv = argv.dup
    end

    def parse
      OptionParser.new do |opts|
        opts.banner = 'Usage: ./demo.rb num_group'
      end.parse!(@argv)
      @argv.shift
    end
  end
end
