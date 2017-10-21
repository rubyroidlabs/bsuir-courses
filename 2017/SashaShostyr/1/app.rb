require_relative('tree')
require 'pry'
require 'json'

list_of_files = []
Dir.foreach('trees') do |filename|
  list_of_files << filename if filename =~ /^\w/
end
list_of_files.sort!
if ENV['NAME'].nil?
  answer = ''
  list_of_files.each do |filename|
    puts filename
    file_name = 'trees/' + filename
    tree_str = File.read(file_name).delete!("\n")
    tree_arr = JSON.parse(tree_str)
    tr = Tree.new(tree_arr.shift)
    tr.create_tree(tree_arr)
    tr.print_tree
    loop do
      print 'Желаете продолжить? [y/n] '
      answer = gets.chomp
      break if %w(y n).include? answer
      puts 'Введите: [y/n]'
    end
    if answer == 'n'
      puts 'Спасибо что были в нашем лесу.'
      break
    end
  end
elsif list_of_files.include? ENV['NAME'] + '.tree'
  file_name = 'trees/' + ENV['NAME'] + '.tree'
  tree_str = File.read(file_name).delete!("\n")
  tree_arr = JSON.parse(tree_str)
  tr = Tree.new(tree_arr.shift)
  tr.create_tree(tree_arr)
  tr.print_tree
else
  puts 'Данное дерево не растет в данном лесу.'
end
