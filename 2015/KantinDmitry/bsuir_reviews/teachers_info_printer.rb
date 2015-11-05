require 'colorize'
require_relative 'text_analyzer.rb'
require_relative 'teacher.rb'
require_relative 'bsuir_teachers.rb'

# Prints colorized info about teachers of concrete group
class TeachersInfoPrinter
  def initialize(group)
    @group = group
  end

  def print
    teachers_names = BsuirTeachers.new(@group).teachers_list
    teachers = teachers_names.map { |teacher| Teacher.new(teacher) }
    output_teachers_info(teachers)
  rescue Errno::ENOENT => ex
    puts 'file error'.red
    puts ex.message
  rescue SocketError
    puts 'internet connection error'.red
  rescue ArgumentError => ex
    puts ex.message.red
  end

  private

  def output_with_analysys(text)
    analyzer = TextAnalyzer.new
    grade = analyzer.analyze(text)
    case grade <=> 0
    when 0
      puts text
    when 1
      puts text.green
    when -1
      puts text.red
    end
  end

  def output_teachers_info(teachers)
    teachers.each do |teacher|
      puts "\t #{teacher.name.blue}"
      teacher.comments.each do |comment|
        output_with_analysys comment
      end
    end
  end
end
