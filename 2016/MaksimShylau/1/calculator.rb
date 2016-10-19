def bin(number) # From 10 to 2 base
  s = ""
  while number.positive?
    s += (number.to_i % 2).to_s
    number /= 2
  end
  s.reverse
end

def nul_bin(dec, count) # ! operation (changes '1' on '0')
  ind = -1
  i = 0
  while i < count && !dec[ind].nil?
    if dec[ind] == "1"
      i += 1
      dec[ind] = "0"
    end
    ind -= 1
  end
  dec.to_s
end

def to_dec(binary) # From 2 to 10 base
  sum = i = 0
  1.upto(binary.size) do
    pow = binary.size.to_i - i - 1
    sum += binary[i].to_i * (2**pow)
    i += 1
  end
  sum
end

def oper(symbol, a, b)
  case symbol
  when "+" then a + b
  when "-" then a - b
  when "*" then a * b
  when "/" then a / b
  when "!" then to_dec(nul_bin(bin(a), b))
  end
end
a = []
i = -1
loop do
  i += 1
  a[i] = gets.chomp
  break if a[i] == "+" || a[i] == "-" || a[i] == "*" || a[i] == "/" || a[i] == "!"
end
j = 0
res = oper(a[i], a[i - 2].to_i, a[i - 1].to_i)
ind = i
1.upto(a.size - 3) do
  j += 1
  a[i + j] = gets.chomp
  res = oper(a[i + j], a[ind - 3].to_i, res)
  ind -= 1
end
puts "#=> " + res.to_s
