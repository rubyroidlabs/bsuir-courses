require 'open-uri'
require 'colorize'
require 'gems'
require 'optparse'

require_relative 'fetcher.rb'
require_relative 'input_parse.rb'
require_relative 'filter.rb'
require_relative 'Printer.rb'

input_parse = InputParse.new(ARGV)
fetcher = Fetcher.new(input_parse.gem_name)
versions = fetcher.find_versions
filter = Filter.new(versions, input_parse.filter_options)
printer = Printer.new(versions)
printer.print(filter.filtered_versions)
