require 'optparse'

# parse @argv
module Gemfiler
  class Args
    SIGN_FORMAT = /(~>|>=|<)/
    VER_FORMAT = /(\d+(?:\.[0-9A-Za-z-]+)*)/

    def initialize(argv)
      @argv = argv
    end

    def parse
      OptionParser.new do |opts|
        opts.banner = 'Usage: gv.rb [gem name] [gem versions]'
        opts.on('-h', '--help', 'Write this help') do
          puts opts
          exit
        end
      end.parse!(@argv)
      gem_name = @argv.shift
      conditions = []
      @argv.each do |condition|
        sign, ver = condition.squeeze(' ').split(' ')
        validate_condition!(sign, ver)
        conditions << { sign: sign, ver: ver }
      end
      { gem_name: gem_name, conditions: conditions }
    end

    def validate_condition!(sign, ver)
      if sign.nil? || ver.nil? || sign !~ SIGN_FORMAT || ver !~ VER_FORMAT
        fail 'Wrong conditions format'
      end
    end
  end
end
