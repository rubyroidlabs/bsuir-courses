print 'Введите глубину дерева: '
depth = gets.chomp.to_i

print 'Введите базовый номер: '
base_number = gets.chomp.to_i

COLS = `tput cols`.to_i

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
  ([0] + row).zip(row + [0]).map { |a, b| a + b }
end

pascals_triangle(base_number).with_index.take(depth).each do |elems, i|
  offset = COLS / 2 + elems.join(' ').length / 2
  puts format("%d:%#{offset}s", i, elems.join(' '))
end
