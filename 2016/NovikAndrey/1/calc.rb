def bin(var2, var1)
  j = 0
  tmp = var1.to_s(2).reverse.split("")
  tmp.each_index do |i|
    if tmp[i] == "1" && j < var2
      j += 1
      tmp[i] = "0"
    end
  end.join("").reverse.to_i(2)
end

array = []
loop do
  var = gets.chomp
  if var == var.to_i.to_s
    array.push(var.to_i)
  else
    case var
    when "+"
      array.push(array.pop + array.pop)
    when "-"
      array.push(array.pop - array.pop)
    when "*"
      array.push(array.pop * array.pop)
    when "/"
      array.push(array.pop / array.pop)
    when "!"
      array.push(bin(array.pop, array.pop))
    end
    break if array.length == 1
  end
end

puts "#=> #{array[0]}"
