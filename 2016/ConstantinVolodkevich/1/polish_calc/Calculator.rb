require './rpn_calc'

puts "Can't wait for your task in reverse polish notation:"
text = gets.chomp
calculator = RPN_calc.new
puts calculator.calc(text)

