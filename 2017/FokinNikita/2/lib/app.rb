require_relative 'parser/parser'
require_relative 'battle/battle'

name = ENV['NAME']
criteria = ENV['CRITERIA']

agent = Parser.new
agent.get_links
battles = agent.get_battles(name)
win = 0
los = 0
battles.each do |battle|
  battle.analyze_text(criteria)
  battle.print_result
  unless name.nil?
    battle.win?(name) ? win += 1 : los += 1
  end
end
puts 'Win: ' + win.to_s + ' Los: ' + los.to_s unless name.nil?
