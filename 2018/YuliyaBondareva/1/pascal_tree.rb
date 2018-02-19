require 'terminfo'

def tree(number, base_number)
  width = TermInfo.screen_size
  puts 'Pascal triangle'.center(width[1].to_i)
  number.times do |index|
    trn = [base_number]
    temp = base_number
    s = 1
    branch = [' /']
    index.times do
      temp = ((temp * (index - s + 1)) / s)
      trn.push temp
      s += 1
      branch.push ' /'
    end
    arr_to_str = trn.join('   ')
    str_end = branch.join('  \\')
    puts "#{index + 1}:" + ' ' + arr_to_str.center(width[1].to_i)
    if index != (number - 1)
      puts '  ' + "#{str_end}  \\".center(width[1].to_i)
    end
  end
end

puts 'Depth?'
number = gets.chomp
base_number = ENV['BASE']
if number.to_i <= 0
  loop do
    puts 'depth must be positive. '
    puts 'Depth?'
    number = gets.chomp
    break if number.to_i > 0
  end
elsif base_number.to_i <= 0
  loop do
    puts 'BASE must be positive. '
    puts 'BASE?'
    base_number = gets.chomp
    break if base_number.to_i > 0
  end
end
tree(number.to_i, base_number.to_i)
