#!/usr/bin/env ruby
require 'optparse'
Dir['../lib/*.rb'].each { |f| require_relative f }

option_parser = OptionParser.new do|opts|
  opts.banner = "How to:   ./gemfiler [gem_name] [gem_versions]\n" +
  "Examples: ./gemfiler devise '~> 2.1.3'"
end
option_parser.parse!

begin
  raise ArgumentError if ARGV.size != 2
  argument_parser = Parser.new(ARGV)
rescue ArgumentError => error
  print error, ". Wrong format. Try again.\n"
end

versions = Searcher.new(argument_parser.gem_name).search
filtered_versions = Filtrator.new(argument_parser.version_specifier).filter(versions)
colorized = Colorizer.new(versions, filtered_versions).colorize
