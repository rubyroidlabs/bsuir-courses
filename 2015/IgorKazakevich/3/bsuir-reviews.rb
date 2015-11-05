require 'mechanize'
require 'slop'
require 'colored'
require 'yaml'
require 'unicode'

require_relative './teachers.rb'
require_relative './comment.rb'
require_relative './print.rb'

printer = Print.new

begin
  Teachers.new.find_teachers.each do |teacher|
    comment = Comment.new(teacher)
    comment.find
    comment.text_comments
    printer.print(teacher, comment.text_comments, comment.date_comments)
  end
rescue StandardError
  puts 'Error connection or incorrect input!'
  exit
end
