require_relative 'parser/parser'
require_relative 'battle/battle'

name = ENV['NAME']
criteria = ENV['CRITERIA']

agent = Parser.new
agent.get_links
battles = agent.get_battles(name)
battles.each do |battle|
  battle.analyze_text(criteria)
  battle.print_result
  battle.save_stat(name) unless name.nil?
end
Battle.print_stat