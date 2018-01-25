require_relative 'tree.rb'
require 'json'

files = Dir['/home/dshaido/trees/*.tree']
files_list = Array[]
files.each do |file_name|
  files_list.push(file_name) unless File.directory?(file_name)
end

files_list = files_list.sort
if ENV['NAME'].nil?
  files_list.each do |file_name|
    name = File.basename(file_name)
    tree_array = JSON.parse(File.read(file_name))
    tree = Tree.new(name, tree_array)
    tree.print_tree
    print 'Желаете продолжить? [y/n] '
    break if gets.chomp == 'n'
  end
elsif ENV['NAME']
  files_list.each do |file_name|
    next unless file_name.include? ENV['NAME']
    tree_name = File.basename(file_name)
    tree_array = JSON.parse(File.read(file_name))
    tree = Tree.new(tree_name, tree_array)
    puts tree.name
    tree.print_nodes(tree.tree_array)
  end
end
puts 'Спасибо что были в нашем лесу.'
