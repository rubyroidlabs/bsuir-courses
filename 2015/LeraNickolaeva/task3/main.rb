require 'mechanize'
require 'unicode'

Dir[File.expand_path('./../*.rb', __FILE__)].each { |f| require(f) }

printer = Print.new

begin
  Teachers.new.find_teachers.each do |teacher|
    comment = Comments.new(teacher)
    comment.find
    comment.text_comments
    printer.print(teacher, comment.text_comments, comment.date_comments)
  end
rescue StandardError
  puts 'Error! Something was wrong'
  exit
end
