require_relative 'battles_list'

if ENV['NAME'] && ENV['CRITERIA']
  a = BattlesList.new(ENV['NAME'], ENV['CRITERIA'])
  a.parse_battles_of_mc
elsif ENV['NAME']
  a = BattlesList.new(ENV['NAME'])
  a.parse_battles_of_mc
else
  a = BattlesList.new
  a.parse_battles
end
