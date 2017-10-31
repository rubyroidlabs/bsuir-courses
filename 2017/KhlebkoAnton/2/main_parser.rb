require_relative 'battler'
require 'mechanize'
require 'pry'

name = ENV['NAME']
criteria = ENV['CRITERIA']

person = Battler.new(name, criteria)
person.getbattles
person.parse_battles
person.make_conclusion
