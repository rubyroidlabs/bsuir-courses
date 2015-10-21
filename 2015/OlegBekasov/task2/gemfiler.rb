#!/usr/bin/env ruby
Dir[File.expand_path(('./../lib/*.rb'), __FILE__)].each {|file| require file }
raise ArgumentError if (ARGV.size < 1 || ARGV.size > 3)
versions = VersionGet.new(ARGV[0]).collect
VersionPuts.new(versions, ARGV[1], ARGV[2]).print_filtered
