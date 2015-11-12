require 'mechanize'
require 'colorize'
require 'unicode'

Dir[File.expand_path('../lib/*.rb', __FILE__)].each { |f| require(f) }

group_number = ARGV[0]
if group_number == '-h' || group_number.nil?
  abort 'To start write like this: ruby bsuir-review.rb [group_number]'.red
end

begin
  sch = ScheduleParser.new
  comments = []
  teacher_info = {}
  helper_parser = BsuirHelperParser.new

  sch.get_teachers(group_number).each do |teacher|
    comments = helper_parser.get_comments(teacher)
    if comments == -1
      teacher_info.merge!(teacher => 'No comments')
    else
      teacher_info.merge!(teacher => comments)
    end
  end

  comments_analyzer = CommentsAnalyzer.new

  teacher_info.each do |teacher, comment|
    puts teacher
    puts '====='
    if comment == 'No comments'
      puts comment
      next
    end
    comment.each do |helper_comment|
      if comments_analyzer.positive_comment?(helper_comment) == 1
        puts helper_comment.green
      elsif comments_analyzer.positive_comment?(helper_comment) == -1
        puts helper_comment.red
      else
        puts helper_comment
      end
    end
  end

rescue SocketError
  puts 'Error. Check your Internet connection'.red
rescue ArgumentError
  puts 'Error. Check command line arguments!'.red
end
