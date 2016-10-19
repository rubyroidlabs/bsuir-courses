input = ""
numbers = []
operator_regex = Regexp.new(%r/[\+\-\*\/]{1,}/)

def opz(operator, numbers)
  b = numbers.pop
  a = numbers.pop
  case operator
  when "*" then numbers.push(a * b)
  when "/" then numbers.push(a / b)
  when "+" then numbers.push(a + b)
  when "-" then numbers.push(a - b)
  end
end

loop do
  if (input = gets.chomp) =~ /\d/
    numbers.push input.to_i
  elsif !input.match(operator_regex)
    puts "something wrong"
  else
    opz(input, numbers)
    break
  end
end

(numbers.count - 1).times do
  operator = gets.chomp
  if input.match(operator_regex)
    opz(operator, numbers)
  else
    puts "input operation"
  end
end
puts numbers.first
