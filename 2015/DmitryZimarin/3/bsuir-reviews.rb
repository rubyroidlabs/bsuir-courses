require 'rubygems'
require './Classes/Printer.rb'

if ARGV.include?('-h') || ARGV.length == 0
	puts 'Enter group number, lectors about you want to see reviews'
else
  printer = Printer.new(ARGV[0])
  printer.print_teacher
end
