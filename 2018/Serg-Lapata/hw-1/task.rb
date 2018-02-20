def triangle(height, start_value)
  rows = []

  height.times do |row_number|
    current_value = start_value
    row = [current_value]
    k = 1
    row_number.times do
      current_value = current_value * (row_number - k + 1) / k
      row << current_value
      k += 1
    end
    rows << row
  end

  print_triangle(rows)
end

def check_integer(int)
 int.positive? ? int : raise('Got invalid number')
end

def start_value
  int = ENV['BASE_NUMBER']

  unless int
    puts 'Enter start value'
    int = gets
  end

  check_integer(int.to_i)
end

def print_triangle(rows)
  width_element = rows.last.max.to_s.length + 1
  width_last_row = width_element * rows.last.length

  rows.each.with_index do |row, row_number|
    row_data = row.map do |element|
      element.to_s.center(width_element)
    end.join.center(width_last_row)

    puts "#{row_number}: #{row_data}"
  end
end

puts 'Enter height triangle'
height_triangle = gets.to_i
check_integer(height_triangle)
triangle(height_triangle, start_value)
