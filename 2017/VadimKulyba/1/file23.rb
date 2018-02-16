load 'tree.rb'
require 'json.rb'

def work_with_trees(names_for_trees)
  j = 2
  while j < names_for_trees.length
    puts names_for_trees[j]
    file = File.read('trees/' + names_for_trees[j])
    file = JSON.parse(file)
    tree = Tree.new
    tree.create(file)
    tree.print
    sum = 0
    tree.new_array.each do |first_level_element|
      sum = first_level_element.inject(sum) do |result, element|
        result + element
      end
    end
    if sum > 5000
      puts 'Срубить'
    elsif tree.new_array.count > 5
      puts 'Дерево надо обрезать'
    elsif tree.new_array.count <= 5 && sum < 5000
      puts 'Оставить'
    end
    puts 'Желаете продолжить? [y/n]'
    input = gets.to_s
    break if input.chomp == 'n'
    j += 1
  end
end
# main
names = Dir.foreach('trees').sort { |x, y| y <=> x }.reverse
work_with_trees(names)
