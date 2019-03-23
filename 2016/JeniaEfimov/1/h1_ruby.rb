#!/usr/bin/env ruby

require "./lib/polish_notation.rb"

object = PolishNotation.new
expression = []

loop do
  expression << gets.chomp
  if object.right_input(expression)
    object.evaluate(expression)
    expression = []
  end
end
