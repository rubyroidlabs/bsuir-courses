require 'slop'
class ParsingCommandLine
  def initialize
    @opts = Slop.parse do |o|
      o.string '...'
    end
    @conditions = Array.new
    @hash_map = Hash.new { '' }
    parsing_command_line
  end

  def parsing_command_line # parsing command-line options
    @name = @opts.arguments[0].to_s
    1.upto(@opts.arguments.size) do |i|
      @conditions << @opts.arguments[i]
    end
  end

  def get_conditions # get hash_map with conditions comparison
    @conditions.each do |element|
      if !element.nil?
        s = element.split
        key = s[0].to_s
        value = Gem::Version.new(s[1].to_s)
        case key
        when '~>'
          @hash_map['>='] = value
          @hash_map['<'] = value.bump
        else
          @hash_map[key] = value
        end
      end
    end
    @hash_map
  end

  def get_name
    @name
  end

  def get_count_arguments
    @opts.arguments.size
  end
end
