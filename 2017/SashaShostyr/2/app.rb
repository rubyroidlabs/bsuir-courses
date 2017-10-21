require_relative 'parser'
require_relative 'battle'
require_relative 'statistic'

parser = Parser.new
data = parser.get_data
statistic = Statistic.new(ENV['NAME']) unless ENV['NAME'].nil?
data.each do |d|
  battle = Battle.new
  battle.start_battle(d, statistic)
end
nick = statistic.nickname
lost = statistic.losses
won = statistic.victories
puts "#{nick} won #{won} times, lost #{lost} times." unless statistic.nil?
