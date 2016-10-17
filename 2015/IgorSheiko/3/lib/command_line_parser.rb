require 'slop'

class CommandLineParser
  def initialize
    @opts = Slop.parse do |o|
      o.banner = 'Usage: ruby bsuir_shedule_parser.rb [number_group]
        Examples: ruby bsuir_shedule_parser.rb 251006'
      o.string '...'
      o.on('-h') do
        puts o
        exit
      end
    end
  end

  def argument_count
    if @opts.arguments.count == 1
      @opts.arguments.count
    else
      puts 'Usage: ruby bsuir_shedule_parser.rb [number_group]
      Examples: ruby bsuir_shedule_parser.rb 251006'
      exit
    end
  end

  def name_group
    @opts.arguments[0]
  end
end
