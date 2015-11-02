require 'colorize'

class InputParser
  attr_accessor :operators

  def check(*)
    @operators.values.each do |i|
      if Gem::Version.correct?(i) == false
        puts '(╯°□°)╯︵ ┻━┻ (check your version formatting)'.red
        exit
      end
    end
  end

  def initialize(operators)
    @gname = gname
    operators.flatten!
    operators.map! &:split
    @operators = Hash[operators]
    check @operators
  end
end
