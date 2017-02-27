require 'slop'

class ConsoleParser
  def initialize
    @opts = Slop::Options.new
    @opts.banner = 'Usage: ./bsuir-reviews.rb group_number'
    @opts.on '-h', '--help' do
      puts @opts.banner
      puts 'Example: ./bsuir-reviews.rb 520601'
      exit
    end

    @parser = Slop::Parser.new(@opts)
  end

  def parse_console_param(args)
    result = args.replace @parser.parse(args).arguments
    fail if result.count != 1
    result[0]
  rescue
    puts @opts
    abort
  end
end
