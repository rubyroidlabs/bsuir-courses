#!/usr/bin/env ruby
Dir['../lib/*.rb'].each { |f| require_relative f }

fail ArgumentError if ARGV.size != 2

name, condition = ARGV

versions = Fetcher.new(name).fetch

filtered_versions = VersionFilter.new(versions).fetch(condition)

Vizualizer.new(filtered_versions).visualize
