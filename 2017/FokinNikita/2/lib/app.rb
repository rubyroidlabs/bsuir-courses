require_relative 'parser/parser'
require_relative 'battle/battle'

name = ENV['NAME']
criteria = ENV['CRITERIA']

agent = Parser.new
agent.getLinks
battles = agent.getBattles(name)
battles.each do |battle|
  battle.analyzeText(criteria)
  battle.printR
  battle.saveStat(name) unless name.nil?
end
Battle.printStat