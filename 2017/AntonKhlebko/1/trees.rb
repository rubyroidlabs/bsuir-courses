require 'rubygems'
require 'json'
require 'zip/zip'
require_relative 'Binary_Tree'
require_relative 'functions'

if ENV['NAME'].nil?
  name_not_given
else
  name = 'trees/' + ENV['NAME'] + '.tree'
  checker = 0
  Zip::File.open('trees.zip') do |zip_file|
    zip_file.each do |entry|
      if entry.name != name
        next
      else
        checker = 1
        puts entry.name
        a = entry.get_input_stream.read
        a = JSON a
        tree = BinaryTree.new(a[0], 1)
        tree.create_tree(a, 1)
        tree.max = 0
        tree.max_depth(tree)
        tree.fake_it(tree.max)
        tree.print_tree(tree.max)
        if checker == 1
          puts 'Спасибо, что посмотрели на наше дерево!'
          break
        end
      end
    end
    if checker.zero?
      puts 'Такого дерева в лесу нет :СССССССССССССС'
    end
  end
end
