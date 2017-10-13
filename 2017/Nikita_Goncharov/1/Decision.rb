def get_decision(sum, depth)
  puts "Sum is #{sum}\nDepth is #{depth}"
  if sum > 5000
    puts 'Срубить'
  elsif depth > 5
    puts 'Обрезать'
  else
    puts 'Оставить'
  end
end