#!/usr/bin/env ruby
require 'optparse'
require 'colored'
Dir[File.expand_path(('./../lib/*.rb'), __FILE__)].each { |file| require file }
OptionParser.new do |opts|
  opts.banner = <<-STR
    Usage: ./gemfilter.rb [name] [version]
    For example:
    ./gemfiler devise '~> 2.1.3'
    ./gemfiler rails '>= 3.1'
    ./gemfiler rails '>= 3.1' '< 4.0'
  STR
end.parse!
if ARGV.size < 1 || ARGV.size > 3
  raise ArgumentError.new('Use ./gemfilter.rb -h for help'.red)
end
begin
  versions = VersionGet.new(ARGV[0]).collect
  VersionPuts.new(versions, ARGV[1], ARGV[2]).print_filtered
rescue
end
