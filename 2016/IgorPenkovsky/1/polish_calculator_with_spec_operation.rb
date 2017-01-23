puts "input reverse polish notation"
first_num = gets.chomp.to_i
second_num = gets.chomp.to_i
third = gets.chomp
if third =~ /\D/
  case third
  when "+"
    result = first_num + second_num
  when "-"
    result = first_num - second_num
  when "*"
    result = first_num * second_num
  when "/"
    result = first_num / second_num
  else
    puts "Error"
  end
  puts result.to_s
  exit
end
forth = gets.chomp
if forth =~ /\D/
  fifth = gets.chomp
  if fifth =~ /\D/
    case forth
    when "+"
      result = second_num + third.to_f
    when "-"
      result = second_num - third.to_f
    when "*"
      result = second_num * third.to_f
    when "/"
      result = second_num / third.to_f
    else
      puts "Error"
    end
  end
  case fifth
  when "+"
    result += first_num
  when "-"
    result -= first_num
  when "*"
    result *= first_num
  when "/"
    result /= first_num
  else
    puts "Error"
  end
end
puts result.to_s
