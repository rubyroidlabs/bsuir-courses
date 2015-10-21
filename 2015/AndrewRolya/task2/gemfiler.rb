#!/usr/bin/env ruby
Dir['./lib/*.rb'].each { |f| require_relative(f) }

if ARGV.count < 2
  raise ArgumentError.new('Incorrect number of arguments')
end
condition_with_value = Hash.new { '' }
set_versions = ParsingPage.new(ARGV[0]).parsing_page
condition_with_value = ParsingCommandLine.new(ARGV, condition_with_value).parsing_command_line
SearchAndColoring.new(set_versions, condition_with_value).search_and_coloring
