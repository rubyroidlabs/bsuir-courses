#!/usr/bin/ruby
require_relative "lib/numeric_extension"

stack = []
loop do
  line = gets.chomp!
  if %w(+ - / * !).include?(line)
    stack << stack.pop(2).inject(line.to_sym)
    break if stack.size == 1
  else
    stack << line.to_f
  end
end

puts format("#=> %g", stack.first)
