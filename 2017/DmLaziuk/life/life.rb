require_relative 'game_of_life'

life = GameOfLife.new
life.print_board
sleep(0.1)
loop do
  puts "\e[H\e[2J"
  life.run
  life.print_board
  sleep(0.1)
end
