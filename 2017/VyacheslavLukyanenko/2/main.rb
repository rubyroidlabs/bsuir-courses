require_relative 'lib/rap_playground.rb'
name = ENV['NAME']
criteria = ENV['CRITERIA']
Yo = RapPlayground.new(name, criteria)
Yo.load_battles
