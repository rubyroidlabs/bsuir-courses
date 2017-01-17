require_relative "./calculator.rb"
require "colored"

loop do
  system "clear"
  puts 'Input expression: '

  calc = Calculator.new(gets.chomp)

  puts "\nCorrect expression : #{calc.expression.join(' ')}"

  notation = calc.notation
  puts "Result OPN: #{notation.join(' ')}"

  result = calc.result
  puts "Result: #{result}\n"

  puts 'press any key...'
  gets
end
