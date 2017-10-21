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
puts "#{statistic.nickname} won #{statistic.victories} times, lost #{statistic.losses} times." unless statistic.nil?
