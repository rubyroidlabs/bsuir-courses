class Triangle 
  
  def initialize (base_number,deep) 
    @base_number=base_number
    @deep=deep
  end
  
  def fact(a)
    (1..a).reduce(:*)
  end

  def binomial(n,k)
    return @base_number if n-k <= 0 || k <= 0
    fact(n) / (fact(k) * fact(n - k)) * @base_number
  end

  def curr_str (n)
    (0..n).map { |e| binomial(n, e) }
  end
 

  def show
    max_row = curr_str(@deep)
    max_el_size = max_row.max.to_s.size
    width = [`tput cols`.to_i,100].max
    @deep.times do |i|
        string = curr_str(i).map do |el|
        el.to_s.center(max_el_size)
      end.join(" ").center(width)
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
