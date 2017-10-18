require_relative 'lib/site_parser.rb'
name = ENV['NAME']
criteria = ENV['CRITERIA']
SiteParser.new.start(name, criteria)
