# Class for colorized output
class Printer
  def initialize(list)
    @list = list
  end

  def print(pattern)
    @list.each do |str|
      if pattern.include?(str)
        puts str.colorize(:green)
      else
        puts str
      end
    end
  end
end
