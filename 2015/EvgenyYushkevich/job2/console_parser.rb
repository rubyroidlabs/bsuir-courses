require 'colored'
require 'slop'

class ConsoleParser
  def initialize
    @opts = Slop.parse do |o|
      o.string '...'
      o.string '...', default: '>= 0.0'
      o.string '...'
    end
    ending_init
  end

  def ending_init
    @name = @opts.arguments[0]
    @bound1 = @opts.arguments[1]
    @bound2 = @opts.arguments[2]

    check_name
    check_bounds
  end

  def check_bounds
    if @bound1.nil?
      @bound1 = '>= 0.0'
      puts 'Empty required gem version. Using default: >= 0.0'.green
    end
  end

  def check_name
    if @name.nil?
      # raise Exception.new('Empty gem name')
      puts 'Empty gem name'.green
      puts 'Use: ./gemfiler [gem_name] [bound_1] [bound_2]'.green
      puts 'Default gem versions are >= 1.0'.green
      exit
    end
  end

  def get_name
    @name
  end

  def get_bound1
    @bound1
  end

  def get_bound2
    @bound2
  end
end
