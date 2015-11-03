#!/usr/bin/env ruby
# encoding: utf-8

# bsuir-reviews
# @version 0.1.0
# @author S. Ivanouski

require 'colorize'
require 'docopt'
require 'json'
require 'mechanize'
require 'open-uri'
require 'yaml'
require './lib/employees.rb'
require './lib/inputparser.rb'
require './lib/helper.rb'
require './lib/reviewparser.rb'
require './lib/reviewprinter.rb'
require './lib/commentcolorizer.rb'

stdin = InputParser.new(__FILE__)
group_id = stdin.get_group_id

begin
  lecturers = Employees.new(group_id)
rescue SocketError => err
  Helper.connection_error(err)
end

begin
  lecturers = lecturers.get_employees
rescue NoMethodError => err
  Helper.input_error(err)
end

reviews = ReviewParser.new(lecturers)
reviews.search_reviews
reviev_db = reviews.get_reviews

colored_db = ReviewPrinter.new(reviev_db)
colored_db.print_db
#colored_db.colorize_db
#colored_db.colorize_comment

exit 0
