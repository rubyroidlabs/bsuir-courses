#!/usr/bin/env ruby
Dir['../lib/*.rb'].each { |f| require_relative f }

begin
  raise ArgumentError if ARGV.size != 2
  parser = Parser.new(ARGV)
rescue ArgumentError => error
  print error, ". Wrong format. Try again.\n"
end

searcher = Searcher.new(parser.gem_name)
versions = searcher.search

filtrator = Filtrator.new(parser.version_specifier)
filtered_versions = filtrator.filter(versions)

colorizer = Colorizer.new(versions, filtered_versions)
colorizer.colorize