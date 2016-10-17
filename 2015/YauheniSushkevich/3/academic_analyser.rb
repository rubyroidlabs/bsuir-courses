require 'colorize'
require 'thor'

require_relative 'sentiment_analyzer'
require_relative 'bsuir_finder'
require_relative 'teachers_printer'

# Utility for printing opinions
# about teachers BSUIR group
class AcademicAnalyzer < Thor
  desc 'teachers GROUP_NUMBER', 'find opinions about teachers'
  def teachers(group_number)
    group_number = group_number
    group_id = Finder.find_group_id group_number
    teachers = Finder.find_teachers group_id
    teachers.each { |t| t[:comments] = Finder.find_comments t }
    TeachersPrinter.print teachers
  end
end

AcademicAnalyzer.start(ARGV)
