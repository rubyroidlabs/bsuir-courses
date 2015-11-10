require 'mechanize'
require 'colorize'
require 'optparse'
require 'unicode'

SCHEDULE_URL = 'http://www.bsuir.by/schedule/schedule.xhtml?id='
HELPER_URL = 'http://bsuir-helper.ru/lectors'
Dir['./lib/*.rb'].each { |f| require(f) }

group = ArgumentsParser.new(ARGV)
group.check
pages = GetStuff.new
stuff = Analyzer.new

teacher_list = pages.teachers("#{SCHEDULE_URL}#{group.group_number[0]}")
full_teacher_list = pages.full_teachers(teacher_list)
full_teacher_list.each do |name|
  puts "==============\n#{name.yellow}\n=============="
  comments = pages.get_comments(name)
  comments.each { |com| stuff.analyze(com) }
end
