require_relative 'lib/RapPlayground.rb'
name = ENV['NAME']
criteria = ENV['CRITERIA']
p 1
Yo = RapPlayground.new(name, criteria)
Yo.load_battles
