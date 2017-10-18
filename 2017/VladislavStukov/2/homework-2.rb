require_relative 'SiteParser.rb'
name = ENV['NAME']
criteria = ENV['CRITERIA']
SiteParser.new.start(name, criteria)