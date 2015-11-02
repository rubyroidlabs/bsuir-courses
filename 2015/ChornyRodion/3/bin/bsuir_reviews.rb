
Dir[File.expand_path('../../lib/*.rb', __FILE__)].each { |f| require(f) }
require 'mechanize'
require 'colorize'
require 'sentimental'
require 'microsoft_translator'
require 'optparse'

input_parser = InputParser.new(ARGV)
input_parser.parse
group_id = input_parser.group_id

fetcher = Fetcher.new(group_id)
# fetcher.retrieve_names
comments = fetcher.retrieve_comments

printer = Printer.new(comments)
printer.sentiment_output
