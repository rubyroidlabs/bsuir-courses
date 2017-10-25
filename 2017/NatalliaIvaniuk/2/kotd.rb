require_relative 'parser'
require_relative 'battle'

parser = Parser.new
array_of_text = parser.receive_text
array_of_text.each do |text|
  battle = Battle.new
  battle.divide_data(text)
  battle.winner(text)
end
