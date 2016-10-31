#!/usr/bin/env ruby
require_relative "./lib/RPNCalculator.rb"

calc = RPNCalculator.new
p "Input rpn ex - reverse polish notation example"
a = gets.chomp
calc.evaluate(a)
