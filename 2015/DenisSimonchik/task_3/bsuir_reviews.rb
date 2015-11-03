#!/usr/bin/env ruby
require 'mechanize'
require 'active_support/all'
require 'nokogiri'
require 'open-uri'
require 'colorize'

require_relative '../task_3/lib/downloader.rb'
require_relative '../task_3/lib/group.rb'
require_relative '../task_3/lib/parser.rb'

puts 'Information processing... Wait...'
puts '_______________________________________________________________________________________________________'

parser = Parser.new
group = Group.new(parser.num_of_group)

downloader = Downloader.new
group.schedule_page = downloader.get_page_nokogiri(group.schedule_link)
group.get_all_lectors

all_lectors_from_helper = []
page = downloader.get_page('http://bsuir-helper.ru/lectors')
  page.links_with(href: /lectors/).each do |link|
    all_lectors_from_helper << link
  end

all_lectors_from_helper = all_lectors_from_helper[4..-1]

all_lectors_from_helper_hash = {}

all_lectors_from_helper.each do |lector|
  temp_lector = lector.to_s.split(/[ ' ' \.?!]+/) 
  temp_lector = temp_lector[0] + ' ' + temp_lector[1][0] + '. ' + temp_lector[2][0] + '.  '
  all_lectors_from_helper_hash[temp_lector] = lector
end

group.get_lectors_from_helper(all_lectors_from_helper_hash)
group.get_opinions
group.print_opinions