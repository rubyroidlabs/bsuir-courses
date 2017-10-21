require_relative 'Battler'
require 'mechanize'
require 'pry'

name = ENV['NAME']
criteria = ENV['CRITERIA']

battler = Battler.new(name, criteria)
battler.get_battles
battler.parse_battles
battler.make_conclusion
