require_relative 'parser'
require_relative 'battle'


@stats = []
parser = Parser.new
data = parser.get_battle_data

data.each do |t|
  battle = Battle.new
  battle.set_battle(t)
  @stats << battle.stats unless ENV['NAME'].nil?
end
wins = @stats.count(1)
losses = @stats.count(0)
unless ENV['NAME'].nil?
  puts "#{ENV['NAME']} wins #{wins} times, loses #{losses} times."
end
