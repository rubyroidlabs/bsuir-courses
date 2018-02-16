require 'zip/filesystem'
require 'pry'
require_relative 'tree'

list_of_trees = []
Zip::File.open('trees.zip') do |trees_zip|
  trees_zip.each { |t| list_of_trees << t }
end
list_of_trees.sort!.shift
if ENV['NAME'].nil?
  user_answer = ''
  list_of_trees.each do |filename|
    file_name = filename.to_s.split('/')
    puts file_name[1].to_s
    Zip::File.open('trees.zip') do |trees_zip|
      tree = Tree.new(eval(trees_zip.file.read(filename.to_s)))
      tree.print_tree
      tree.rules
    end
    loop do
      print 'Желаете продолжить? [y/n]: '
      user_answer = gets.chomp
      break if %w(y n).include? user_answer
      puts 'Введите: [y/n]'
    end
    if user_answer == 'n'
      puts 'Спасибо, что были в нашем лесу'
      break
    end
  end
elsif list_of_trees.to_s.include? 'trees/' + ENV['NAME'] + '.tree'
  file_name = 'trees/' + ENV['NAME'] + '.tree'
  puts ENV['NAME'] + '.tree'
  Zip::File.open('trees.zip') do |filenames|
    tree = Tree.new(eval(filenames.file.read(file_name)))
    tree.print_tree
    tree.rules
  end
else
  puts 'Данное дерево не растет в нашем лесу.'
end
