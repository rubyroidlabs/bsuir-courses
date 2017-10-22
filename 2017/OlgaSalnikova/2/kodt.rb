require_relative 'king_of_the_dot'

king_of_the_dot = KingOfTheDot.new(ENV['NAME'], ENV['CRITERIA'])

king_of_the_dot.print_all_battles_log
