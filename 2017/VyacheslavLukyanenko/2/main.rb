require_relative 'lib/RapPlayground.rb'
name = ENV['NAME']
criteria = ENV['CRITERIA']
Yo = RapPlayground.new(name, criteria)
Yo.load_battles
