require 'colorize'

class InputParser
  attr_accessor :gname, :operators, :correct

  def initialize(gname, operators)
    @gname = gname
    operators.flatten!
    operators.map! &:split
    @operators = Hash[operators]
    begin
      @operators.values.map! do |i|
        Gem::Version.new(i)
      end
      rescue ArgumentError
        puts 'Error aquired! Please, check your version formatting.'.red
        exit
      end
  end
end
