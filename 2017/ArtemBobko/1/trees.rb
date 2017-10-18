require 'json'
require 'zip'
require_relative 'tree_functions'

Zip.on_exists_proc = true

if !ENV['NAME'].nil?
  file_name = "#{ENV['NAME']}.tree"
  Zip::File.open('trees.zip') do |zip_file|
    if zip_file.find_entry('trees/' + file_name)
      tree = JSON.parse(zip_file.read('trees/' + file_name))
      Tree.print_tree(tree)
    else
      puts 'Данное дерево не растет в данном лесу.'
    end
  end
else
  Zip::File.open('trees.zip') do |zip_file|
    zip_file.glob('trees/*.tree').sort.each do |file|
      tree = JSON.parse(zip_file.read(file.name))
      Tree.print_tree(tree) # tree output
      puts file.name
      sum = Tree.sum(tree) # find nodes sum
      height = Tree.height(tree) # find nodes height
      puts "Cумма листьев: #{sum}"
      puts "Сумма листьев: #{sum}"
      puts "Глубина дерева: #{height}"
      if sum > 5000
        zip_file.remove(file.name)
        puts 'Срубить'
      elsif height > 5
        Tree.cut(tree) # cut tree
        new_tree = JSON.generate(tree)
        zip_file.get_output_stream(file.name) { |f| f.puts new_tree }
        puts 'Обрезать'
      end
      print "\nЖелаете продолжить?[y/n] "
      break if gets.chomp == 'n'
    end
    zip_file.commit
  end
  puts 'Спасибо, что были в нешем лесу!'
end
