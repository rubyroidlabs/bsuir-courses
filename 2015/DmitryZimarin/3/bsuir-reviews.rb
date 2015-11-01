require 'rubygems'
require './Classes/Printer.rb'

class ConsoleReader
  def initialize
    if ARGV.include?('-h') || ARGV.length == 0
      print_help
    else
      printer = Printer.new(ARGV[0])
      printer.print_teacher
    end
  end

  def print_help
    puts 'Enter group number, lectors about you want to see reviews'
  end
end

ConsoleReader.new
