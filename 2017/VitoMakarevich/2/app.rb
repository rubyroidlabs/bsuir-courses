require_relative 'list_parser'
require_relative 'battle'
require_relative 'battle_parser'
query = ENV['NAME']
criteria = ENV['CRITERIA']
lp = ListParser.new(query)
bp = BattleParser.new
total = { win: 0, lose: 0, draw: 0 }
lp.songs.each do |song|
  battle_result = bp.parse(song).result(criteria)
  if query
    if !battle_result[:winner]
      total[:draw] += 1
    elsif battle_result[:winner].downcase.match?(/#{query.downcase}/)
      total[:win] += 1
    else
      total[:lose] += 1
    end
  end
  puts "\n#{song['title']}  #{song['url']}#{battle_result[:result_text]}"
end
if query
  result = "\n#{query} \
  WINS #{total[:win]} \
  LOSES #{total[:lose]} \
  DRAWS #{total[:draw]}"
  puts result
end
