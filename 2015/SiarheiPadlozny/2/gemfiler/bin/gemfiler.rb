#!/usr/bin/env ruby
Dir['../lib/*.rb'].each { |f| require_relative f }
begin
  if ARGV.size < 2
    fail ArgumentError, 'USAGE: <gem name> <filter>'
  else
    versions = Fetcher.get_versions ARGV.shift
    requirements = ARGV
    filtered = Filter.get_filtered_versions versions, requirements
    Writer.write_to_console versions, filtered
  end
rescue ArgumentError => e
  puts e.message
  exit
end
