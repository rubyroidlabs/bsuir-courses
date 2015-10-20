require 'rubygems'
require 'nokogiri'
require 'open-uri'
require './html_parser'
require './version_checker'
require './visualizer.rb'

if ARGV.length < 2 || ARGV.length > 3
  puts 'Incorrect number of arguments'
  puts 'Template: ./gemfiler <gem_name> [\'version conditions\']'
  exit
end

begin
  versions_list = HTMLParser.new(ARGV[0]).get_versions
rescue StandardError
  puts 'Oops! Something with your internet connection'
  exit
end

versions_hash =
  VersionChecker.check_versions(versions_list, ARGV[1...ARGV.length])

Visualizer.new(versions_hash).print
