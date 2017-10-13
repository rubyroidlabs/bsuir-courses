require 'rubygems'
require 'json'
require 'zip/zip'
require_relative 'binary_tree'
require_relative 'functions'

if ENV['NAME'].nil? || ENV['NAME'] == ""
  name_not_given
else
  name = 'trees/' + ENV['NAME'] + '.tree'
  checker = false
  Zip::File.open('trees.zip') do |zip_file|
    zip_file.each do |entry|
      if entry.name != name
        next
      else
        checker = true
        puts entry.name
        a = entry.get_input_stream.read
        a = JSON.parse(a)
        tree = BinaryTree.new(a[0], 1)
        tree.create_tree(a, 1)
        tree.max = 0
        tree.max_depth(tree)
        tree.fake_it(tree.max)
        tree.print_tree(tree.max)
        puts 'Спасибо, что посмотрели на наше дерево!'
        break
      end
    end
    puts 'Такого дерева в лесу нет :С' unless checker
  end
end
