require 'nokogiri'
require 'curb'
require 'pry'
require 'rubocop'
require 'csv'
require_relative './data/constants.rb'
require_relative './lib/parse.rb'
require_relative './lib/output.rb'

def main
  parser = Parse.new
  parser.get_page_doc
  list = parser.get_list
  file = Output.new('data/imdb')
  file.save_data(list)
end

main
