require 'thor'
require_relative 'teachers_info_printer.rb'

# imput handler
class BsuirReview < Thor
  desc 'get GROUP', 'displays comments about teachers'
  def get(group)
    info_printer = TeachersInfoPrinter.new(group)
    info_printer.print
  end

  desc 'help', 'shows help'
  option aliasses: :h
  def help
    puts 'you should send group number to displays comments about teachers'
    puts 'bsuir_reviews.rb get group_number'
  end
end

BsuirReview.start(ARGV)
