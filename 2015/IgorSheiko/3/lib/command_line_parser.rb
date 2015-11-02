require 'slop'

class CommandLineParser
  def initialize
    @opts = Slop.parse do |o|
      o.banner = 'Usage: ruby bsuir_shedule_parser.rb [number_group]
        Examples: ruby bsuir-reviews.rb 251006'
      o.string '...'
      o.on('-h') do
        puts o
        exit
      end
    end
  end

  def argument_count
    unless @opts.arguments.count == 1
      puts 'Usage: ruby bsuir_shedule_parser.rb [number_group]
        Examples: ruby bsuir-reviews.rb 251006'
        exit
    else 
      @opts.arguments.count
    end
  end

  def name_group
    @opts.arguments[0]
  end
end
