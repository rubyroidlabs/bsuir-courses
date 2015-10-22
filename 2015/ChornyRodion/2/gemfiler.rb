require 'open-uri'
require 'colorize'
require 'gems'
require 'optparse'

require_relative 'fetcher.rb'
require_relative 'input_parse.rb'
require_relative 'filter.rb'

input_parse = InputParse.new(ARGV)
fetcher = Fetcher.new(input_parse.gem_name)
filter = Filter.new(fetcher.find_versions, input_parse.filter_options)
filter.colorize_output
