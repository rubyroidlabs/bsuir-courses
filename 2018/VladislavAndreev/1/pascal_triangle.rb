#!/usr/bin/env ruby
 
print "Введите глубину дерева: "
depth = gets.chomp.to_i

print "Введите базовый номер: "
base_number = gets.chomp.to_i


def pascals_triangle(base_num)
  current = [base_num]

  Enumerator.new do |y|
    loop do
      y << current
      current = pascals_row(current)
    end
  end
end


def pascals_row(row)
  ([0] + row).zip(row + [0]).collect { |a, b| a + b }
end


pascals_triangle(base_number).with_index.take(depth).each do |elems, i|
  puts "%d:%#{`tput cols`.to_i / 2 + (elems.join(' ').length) / 2}s" % [i, elems.join(' ')]
end
