#!/usr/bin/env ruby

require 'colorize'
require 'optparse'
Dir['../sourcelib/*.rb'].each { |f| require_relative(f) }

parser = OptionParser.new do |opts|
  opts.banner = 'Usage: ./check.rb[name][key]'
end
parser.parse!
name, key = ARGV

versions = FindVersion.new(name).find
if versions
  filter_versions = FiltreVersion.new(versions, key.dup).filter
  if filter_versions
    PrintVersion.new(versions, filter_versions).write
  end
end
