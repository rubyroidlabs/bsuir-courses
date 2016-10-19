def convert_to_binary(number)
  [number].pack("G").bytes.map { |n| format("%08b", n) }
  # Will return our number in binary (as array of bit sets - smth like: ["00000000", "01000100", "00111001", ...].
  # If we use .join on this array - we will get our number in binary.
  # But if we want to convert binary number back to float later we need this binary number in such form.
end

def convert_to_float(binary_number)
  binary_number.map { |n| format("%d", "0b#{n}").to_i.chr }.join.unpack("G")[0].to_f
  # Simply will convert our binary number to float
  # !!! Binary number passed to that method should be in such form: ["01000000", "01001101", "11010010", ...]
end

def remove_bits(bits_to_remove, number)
  binary_number = convert_to_binary(number).reverse.map do |n| # reverse our number(it bit sets) because we should delete bits from end
    n.reverse.split("").map do |i| # reverse our bits in bit set beacuse they are still in the order which was when our number wasn't reversed
      if i == "1" && bits_to_remove.positive?
        i = "0"
        bits_to_remove -= 1
      end
      i
    end.reverse.join
  end.reverse
  convert_to_float(binary_number)
end

def calculate(expression)
  expression.each_with_object([]) do |e, s|
    if e =~ %r{/\d/}
      s.push(e.to_f)
    elsif e == "!"
      s.push(remove_bits(s.pop, s.pop))
    else
      s.push(s.pop(2).inject(e).to_f)
    end
    s
  end
end

puts "Reverse Polish Notation calculator"
puts "Type 'exit' to exit. Simple."
puts "Enter your expression:"
expression = []
first_input = true
loop do
  input = gets.chomp
  case input.downcase
  when %r{/(\d|[+-/\*!])/} # regexp that allows only numbers, +, -, /, *, !
    expression.push(input)
    result = calculate(expression)
    if result.length == 1 && !first_input
      puts "Result: #{result[0]}\nWant to continue with that result?(yes/no)"
      case gets.chomp.downcase
      when "yes"
        puts result[0]
      when "exit"
        break
      else
        expression = []
        first_input = true
        puts "New expression:"
        next # needed here because of assignment of 'first_input = false' at 68 line
      end
    end
    first_input = false
  when "exit"
    break
  else
    puts "InputError"
  end
end
