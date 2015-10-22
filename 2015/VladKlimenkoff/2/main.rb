require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'optparse'
require './html_parser.rb'
require './version_checker.rb'
require './visualizer.rb'

parser = OptionParser.new do |opts|
  opts.banner = 'Usage: ./gemfiler <gem_name> \'[version conditions]\''
end
args = parser.parse!

if args.length < 2 || args.length > 3
  puts parser
  exit
end

begin
  versions_list = HTMLParser.new(args[0]).get_versions
rescue StandardError
  puts 'Oops! Something with your internet connection'
  exit
end

versions_hash =
  VersionChecker.check_versions(versions_list, args[1...args.length])

Visualizer.new(versions_hash).print
