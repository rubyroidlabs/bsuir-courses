def convert_to_binary(number)
  [number].pack("G").bytes.map { |n| format("%08b", n) }
end

def convert_to_float(binary_number)
  binary_number.reverse.map { |n| format("%d", "0b#{n}").to_i.chr }.join.unpack("G")[0].to_f
end

def remove_bits(bits_to_remove, number)
  binary_number = convert_to_binary(number).reverse.map do |n|
    n.split("").reverse.map do |i|
      if i == "1" && bits_to_remove.positive?
        i = "0"
        bits_to_remove -= 1
      end
      i
    end.reverse.join
  end
  convert_to_float(binary_number)
end

expression = []
until (input = gets.chomp).empty?
  expression.push(input)
end

if expression.include?("!")
  puts(expression.each_with_object([]) do |e, s|
    if e =~ /[0-9]/
      s.push(e.to_f)
    elsif e == "!"
      s.push(remove_bits(s.pop, s.pop))
    else
      s.push(s.pop(2).inject(e).to_f)
    end
    s
  end)
else
  puts(expression.each_with_object([]) do |e, s|
    if e =~ /[0-9]/
      s.push(e.to_f)
    else
      s.push(s.pop(2).inject(e).to_f)
    end
    s
  end)
end
