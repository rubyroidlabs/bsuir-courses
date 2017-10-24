# /usr/bin/env ruby

require_relative('2.rb')

dir = Dir.new('trees')
path = dir.entries.each.map do |file|
  next unless file =~ /\.tree/
  file
end.compact.sort

tree_name = ENV['NAME']

if tree_name
  if tree_name == ''
    puts('Безымянных деревьев у нас не растёт.')
  elsif path.include?(tree_name + '.tree')
    arr = []
    str = ''
    tree_name = 'trees/' + tree_name + '.tree'
    File.open(tree_name) do |file|
      file = file.read
      arr = file.scan(/\d\d*/)
      str = file.delete '0-9'
    end

    tree = []
    tree = create(arr, str)

    level = 0
    level = get_tree_level(arr)

    max_vertex = arr.size
    tree_show(tree, level, max_vertex)
  else puts('Данное дерево в этом лесу не растёт.')
  end
else
  path.each do |file_name|
    puts file_name
    arr = []
    str = ''
    file_name = 'trees/' + file_name
    File.open(file_name) do |file|
      file = file.read
      arr = file.scan(/\d\d*/)
      str = file.delete '0-9'
    end

    tree = []
    tree = create(arr, str)

    level = 0
    level = get_tree_level(arr)

    max_vertex = arr.size
    tree_show(tree, level, max_vertex)

    if arr.inject { |sum, n| sum.to_i + n.to_i }.to_i > 5000
      puts 'Срубить.'
    elsif get_tree_level(arr) > 5
      puts 'Обрезать.'
    else
      puts 'Оставить.'
    end

    print 'Желаете продолжить? [y/n] '
    choise = gets.chomp.downcase
    break if choise == 'n' || 'trees/' + path[path.size - 1] == file_name
  end

  puts 'Спасибо что были в нашём лесу.'
end
