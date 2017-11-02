require_relative 'battles.rb'

battles = Battles.new
puts 'Подождите пока батлы загрузятся.'
battles.get_all_battles
if ENV['NAME'].nil?
  battles.put_all_battles(ENV['CRYTERIA'])
else
  battles.put_name_battles(ENV['NAME'], ENV['CRYTERIA'])
end
