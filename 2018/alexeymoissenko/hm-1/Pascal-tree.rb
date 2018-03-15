class Triangle
  def initialize(base_number, deep)
    @base_number = base_number
    @deep = deep
  end

  def fact(any_value)
    (1..any_value).reduce(:*)
  end

  def binomial(ln_s, num_in_ln)
    return @base_number if ln_s - num_in_ln <= 0 || num_in_ln <= 0
    fact(ln_s) / (fact(num_in_ln) * fact(ln_s - num_in_ln)) * @base_number
  end

  def curr_str(curr_size)
    (0..curr_size).map { |e| binomial(curr_size, e) }
  end

  def show
    max_row = curr_str(@deep)
    max_el_size = max_row.max.to_s.size
    width = [`tput cols`.to_i, 100].max
    @deep.times do |i|
      string = curr_str(i).map do |el|
        el.to_s.center(max_el_size)
      end.join(' ').center(width)
      puts "#{i + 1}: #{string}"
    end
  end
end

puts 'Введите начальное значение:'

base_number = gets.chomp.to_i

puts 'Введите глубину треугольника:'

deep = gets.chomp.to_i

triangle = Triangle.new(base_number, deep)

triangle.show
