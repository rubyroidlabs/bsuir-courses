def int?(str)
  !!(str =~ /^[-+]?[1-9]([0-9]*)?$/)
end

def reset_units(numbers, res)
  value = numbers.pop
  value_in_bit = value.to_s(2)
  last_number_in_mas = value_in_bit.size - 1
  amount_numbers = amount_numb(res, value_in_bit, last_number_in_mas)
  res_in_string = value_in_bit[0..(last_number_in_mas - amount_numbers)]
  res_in_string += "0" * amount_numbers
  res_in_string.to_i(base = 2)
end

def amount_numb(res, value_in_bit, last_number_in_mas)
  amount_numbers = 0
  number_of_units = 0
  while number_of_units != res.to_i
    number_of_units += 1 if value_in_bit[last_number_in_mas - amount_numbers] == "1"
    amount_numbers += 1
  end
  amount_numbers
end

def run
  numbers = []
  signs = []

  loop do
    number = gets.chomp
    if int?(number)
      numbers << number.to_i
    elsif %w(+ - * ! /).include?(number)
      signs << number
      return p "Error" if numbers.size < 2
      break if signs.size == numbers.size - 1
    else
      return p "Error"
    end
  end

  res = numbers.pop
  signs.each do |n|
    res = case n
          when "+"
            res + numbers.pop
          when "-"
            numbers.pop - res
          when "*"
            res * numbers.pop
          when "/"
            numbers.pop / res
          when "!"
            reset_units(numbers, res)
          end
  end
  p res
end

runs
