require 'slop'

class ParsingCommandLine
  def initialize
    @opts = Slop.parse do |o|
      o.string '...'
    end
    @conditions = Array.new
  end

  def opts_count
    @opts.arguments.count
  end

  def get_gem_name
    @opts.arguments[0]
  end

  def parsing_command_line
    @name = @opts.arguments[0]
    1.upto(@opts.arguments.count - 1) do |i|
      @conditions << @opts.arguments[i]
    end
    @conditions
  end
end
