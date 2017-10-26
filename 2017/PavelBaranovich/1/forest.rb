# /usr/bin/env ruby
require_relative('methods')

dir = Dir.new('trees')
path = dir.entries.each.map do |file|
  next unless file =~ /\.tree/
  file
end.compact.sort

tree_name = ENV['NAME']

if tree_name
  tree_name += '.tree'

  if tree_name == '.tree'
    puts 'Безымянных деревьев у нас не растёт'
  elsif path.include?(tree_name)
    solve(tree_name)
  else
    puts 'Данное дерево не растет в данном лесу'
  end
else
  path.each do |file_name|
    puts file_name

    array = solve(file_name)

    if array.inject { |sum, n| sum.to_i + n.to_i }.to_i > 5000
      puts 'Срубить'
    elsif get_depth(array.size) > 5
      puts 'Обрезать'
    else
      puts 'Оставить'
    end

    print 'Желаете продолжить? [y/n] '
    input = gets.chomp.downcase
    break if input == 'n' || 'trees/' + path[path.size - 1] == file_name
  end

  puts 'Спасибо что были в нашём лесу'
end
