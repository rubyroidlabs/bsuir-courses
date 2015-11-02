#!/usr/bin/env ruby
Dir[File.expand_path('./../lib/*.rb', __FILE__)].each { |f| require(f) }
require 'mechanize'
require 'slop'

opts = Slop.parse do |o|
  o.string '...'
  o.on('-h') do
    puts 'Usage : ruby parser_shedule_group.rb [number_group]'
    exit
  end
end
unless opts.arguments.count == 1
  puts 'Usage : ruby parser_shedule_group.rb [number_group]'
  exit
end
group_number = opts.arguments[0]
parser = ParserSheduleGroup.new(group_number)
teachers_list = parser.proffessors_list
parser = ParserLectors.new
parser_yaml = ParserYaml.new
teachers_list.each do |teacher|
  comments = parser.search_comments(teacher)
  puts teacher
  puts '=' * 5
  if comments != []
    dates = parser.search_dates
    for counter in 0..comments.length-1
      puts "#{dates[counter]}: "
      parser_yaml.execute(comments[counter])
    end
  else
    puts "Не найдено отзывов"
  end
end
