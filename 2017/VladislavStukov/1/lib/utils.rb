require 'json'
require_relative 'tree.rb'

module Utils
  def self.read_tree_by_name(name)
    read_tree_by_path('./trees/' + name + '.tree')
  end

  def self.read_tree_by_path(path)
    begin
      contents = File.read(path)
    rescue SystemCallError => ex
      puts 'Данное дерево не растет в данном лесу.'
      exit
    end
    Tree.new(JSON.parse(contents))
  end

  def self.show_all_trees
    trees = Dir['./trees/*.tree']
    trees.each do |tree_name|
      puts tree_name.split('/').last
      tree = read_tree_by_path(tree_name)
      tree.show_tree
      tree.check
      print 'Желаете продолжить? [Y/n] '
      gets.chomp == 'n' ? break : nil
    end
  end
end
