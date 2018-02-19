#!/usr/bin/env ruby
require 'optparse'
require 'mechanize'
require 'open-uri'
require 'colorize'

Dir['../lib/*.rb'].each { |f| require_relative f }

URL_HELPER  = 'http://bsuir-helper.ru/lectors'
URL_SHEDULE = 'http://www.bsuir.by/schedule/schedule.xhtml'

options = {}
options_parser = OptionParser.new do |opts|
  opts.banner = "How to: ./bsuir_reviewer.rb -g 250501\t\t\t-- " +
                       'this will print all tutors of the group' +
       "\n\t./bsuir_reviewer.rb -g 250501 -t 'Самаль Д. И.' -- " +
                       'this will print reviews about the tutor'

  opts.separator 'Options:'

  opts.on('-g GROUP_NAME', 'Name of the group') do |o|
    options[:group_name] = o
  end

  opts.on('-t TUTOR_ABBR', 'Name of the tutor') do |o|
    options[:tutor_abbr] = o
  end
end

begin
  options_parser.parse!
rescue OptionParser::MissingArgument
  puts 'You should provide arguments. Type -h for example.'
  exit
rescue OptionParser::InvalidOption
  puts 'Wrong type of arguments. Type -h for example.'
  exit
end

GROUP_NAME = options[:group_name]
TUTOR_ABBR = options[:tutor_abbr]

group_parser  = GroupParser.new
review_parser = ReviewParser.new

group_parser.go_to_page(URL_SHEDULE)
group_parser.submit_form(GROUP_NAME)

if TUTOR_ABBR
  group_tutor = group_parser.get_full_name(TUTOR_ABBR)
  review_parser.go_to_page(URL_HELPER)
  reviews     = review_parser.get_reviews(group_tutor)
  colorizer   = Colorizer.new(reviews)
  colorizer.view_colored_reviews
else
  group_parser.view_all_tutors
end
