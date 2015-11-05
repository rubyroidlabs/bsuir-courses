#!/usr/bin/env ruby
# encoding: utf-8

# bsuir-reviews
# @version 0.1.9
# @author S. Ivanouski

require 'colorize'
require 'docopt'
require 'json'
require 'mechanize'
require 'yaml'
require './lib/employees.rb'
require './lib/inputparser.rb'
require './lib/reviewparser.rb'
require './lib/reviewprinter.rb'
require './lib/commentcolorizer.rb'

stdin = InputParser.new(__FILE__)
group_id = stdin.get_group_id

begin
  lecturers = Employees.new(group_id)
rescue SocketError => err
  print "Connection Error!\n#{err}\n"
  exit 1
end

begin
  lecturers = lecturers.get_employees
rescue NoMethodError => err
  print "Check your group id!\n#{err}\n"
  exit 1
end

reviews = ReviewParser.new(lecturers)
reviews.search_reviews
reviev_db = reviews.get_reviews

ReviewPrinter.print_db(reviev_db)

exit 0
