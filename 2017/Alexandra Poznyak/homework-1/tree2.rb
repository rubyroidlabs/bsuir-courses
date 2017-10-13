
require 'rubygems'
require 'json'
  
class Node
  attr_reader :left, :right, :data
  def initialize(data, left = nil, right = nil)
    @left = left
    @right = right
    @data = data
  end
end

class Tree
  def initialize_tree(x)
    if x[0].nil?
      @root = insert(x)
    end
  end
  def insert(x)
    if x.is_a?(Integer)
      Node.new(x)
    else
      Node.new(x[0], insert(x[1][0]), insert(x[1][1]));
    end
  end
  def traverse()
    list = []
    yield @data
    list << @left if @left != nil 
    list << @right if @right != nil  
    loop do
    break if list.empty?
    node = list.shift
    yield node.data
      if node.left
      node.insert(x)
      end
      if node.right
      node.insert(x)
      end
      list << node.left if node.left != nil && node.left 
      list << node.right if node.right != nil && node.right  
      end
    end
  end
  

trees = Dir["./*.tree"].delete_if{|filename| filename == '.' || filename =='..'}.sort! 
  trees.each do |tree_name|
  File.open(tree_name) do |file|
  json = file.read
  tree.insert(json) 
  end	
end

