require 'optparse'

class Parser
  attr_reader :group_number
  BANNER = '    USAGE: [group number (6 digits)]'

  def initialize
    @parser = OptionParser.new do |opts|
      opts.banner = BANNER
      opts.on '-h', '--help', 'Check this for help' do
        puts opts
        exit
      end
    end
  end

  def parse
    args = @parser.parse!
    if args.length != 1
      puts @parser
      exit
    end
    @group_number = args[0]
  end
end
