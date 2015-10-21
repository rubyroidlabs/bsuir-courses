#!/usr/bin/env ruby
Dir['../lib/*.rb'].each { |f| require_relative f }

parser = Parser.new
parser.parse

fetcher = Fetcher.new parser.gem_name
fetcher.versions

filter = Filter.new fetcher.gem_versions, parser.filter
filter.filter_versions

Writer.new(fetcher.gem_versions, filter.filtered_versions).write_to_console
