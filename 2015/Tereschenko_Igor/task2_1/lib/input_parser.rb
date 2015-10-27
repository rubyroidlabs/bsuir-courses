require 'colorize'

class InputParser
  attr_accessor :gname, :operators, :correct

  def check(*)
    @operators.values.each do |i|
      if Gem::Version.correct?(i) == false
        puts 'Error aquired! Please, check your version formatting.'.red
        exit
      end
    end
  end

  def initialize(gname, operators)
    @gname = gname
    operators.flatten!
    operators.map! &:split
    @operators = Hash[operators]
    check @operators
  end
end
