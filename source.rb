require 'pry'
require 'json'

file = IO.read('./trees/' + ENV['NAME'] + '.tree')
puts file

tree = JSON.parse(file.gsub(/(\d+)/, '\1'))

def draw(tree)
  tree.each do |item|
    if item.class == 1.class
      print "#{item} "
    else
      draw item
    end
  end
end

def choice(tree)
  if tree.flatten.sum > 5000
    puts 'Дерево слишком старое. Нужно срубить.'
  elsif Math.log2(tree.flatten.count + 1) > 5
    puts 'Дерево слишком высокое. Нужно укоротить.'
  else
    puts 'Оставить все как есть.'
  end
end
choice tree
# draw tree
