require "rubygems"
require "colorize"
Dir["../lib/*.rb"].each { |f| require_relative(f) }
#:nodoc:
class RpnCalculator
  expression = []

  loop do
    expression << gets.chomp
    if expression.last == "\="
      puts expression
      errors = Error.new
      errors.input_check(expression)
      calculator = Calculator.new
      puts "Unswer: #{expression.map { |exp| exp + ' ' }.join}#{ calculator.count(expression) }"
      exit
    end
  end
end
