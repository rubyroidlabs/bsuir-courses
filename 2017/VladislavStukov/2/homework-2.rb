Dir['./lib/*.rb'].each { |file| require file }

name = ENV['NAME']
criteria = ENV['CRITERIA']

imp_raper = ImportantRaper.new(name) if name # create monitored raper
BattleUtils.get_battle_by(name) do |battle|
  battle.criteria = criteria
  puts battle.result
  puts '=' * 50
  winner_name = battle.winner
  if name
    winner_name.casecmp(imp_raper.name).zero? ? imp_raper.win : imp_raper.lose
  end
end
puts imp_raper.result if name
