require 'rubygems'
require 'nokogiri'
require 'open-uri'
require './html_parser'
require './version_checker'
require './visualizer.rb'

versions_list = HTMLParser.new(ARGV[0]).get_versions

versions_hash = VersionChecker.check_versions(versions_list, ARGV[1])

Visualizer.new(versions_hash).print