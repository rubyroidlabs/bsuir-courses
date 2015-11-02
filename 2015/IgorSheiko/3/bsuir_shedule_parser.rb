Dir[File.expand_path('./../lib/*.rb', __FILE__)].each { |f| require(f) }
require 'optparse'

arguments = CommandLineParser.new
name_group = arguments.name_group
arguments.argument_count
comments_analysis = CommentAnalisis.new
teachers_list = SheduleParser.new(name_group).teachers_list
helper_manager = CommentsTeachers.new
teachers_list.each do |teacher|
  link_teacher = helper_manager.search_comments(teacher)
  puts teacher
  puts '=' * 10
  if link_teacher
    comments_time = helper_manager.time(link_teacher)
    comments_content = helper_manager.content(link_teacher)
    comments_time.count.times do |i|
      puts "#{comments_time[i]}:"
      comments_analysis.analysis(comments_content[i])
    end
  else
    puts "Не найдено отзывов\n\n"
  end
end
