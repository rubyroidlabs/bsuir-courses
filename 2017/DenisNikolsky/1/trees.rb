require 'rubygems'
require 'json'

class Tree
  attr_accessor :left, :right, :data

  def initialize(data = nil)
    @left = nil
    @right = nil
    @data = data
  end

  def insert(item)
    if @data.nil?
      @data = item[0]
      insert(item[1])
    end
    item.each do |node|
      if @left.nil?
        insert_left(node)
      elsif @right.nil?
        insert_right(node)
      end
    end
  end

  def insert_left(node)
    if node.class == [].class
      @left = Tree.new(node[0])
      @left.insert(node[1])
    else
      @left = Tree.new(node)
    end
  end

  def insert_right(node)
    if node.class == [].class
      @right = Tree.new(node[0])
      @right.insert(node[1])
    else
      @right = Tree.new(node)
    end
  end

  def max_depth
    depth = 1
    node = @left
    loop do
      break if node.left.nil?
      depth += 1
      node = node.left
    end
    depth
  end

  def print_tree
    depth = max_depth
    spaces = 40 * depth
    puts format("%#{spaces}i", @data)
    puts format("%#{spaces}s", '/  \\')
    list = []
    list << @left
    list << @right
    print_node(list, depth)
  end

  def print_node(list, depth)
    level = 1
    printed_elem = 0
    loop do
      break if list.empty?
      elements = 2**level
      node_left = list.shift
      node_right = list.shift
      spaces = 40 * depth / elements
      print format("%#{spaces}i", node_left.data)
      print format("%#{spaces * 2}i", node_right.data)
      printed_elem += 2
      add_in_list(list, node_left)
      add_in_list(list, node_right)
      if printed_elem == elements
        puts ''
        return if level == depth
        print_branch(elements, spaces)
        level += 1
        printed_elem = 0
      else
        print ' ' * spaces
      end
    end
  end

  def print_branch(elements, spaces)
    elements.times do
      print format("%#{spaces - 1}s ", '/  \\')
      print ' ' * (spaces + 1)
    end
    puts ''
  end

  def add_in_list(list, node)
    list << node.left unless node.left.nil?
    list << node.right unless node.right.nil?
    list
  end

  def make_decision
    return 'срубить' if sum_nodes > 5000
    return 'обрезать' if max_depth > 5
    'оставить'
  end

  def sum_nodes
    list = []
    sum = @data
    list << @left
    list << @right
    loop do
      break if list.empty?
      node = list.shift
      sum += node.data
      list << node.left unless node.left.nil?
      list << node.right unless node.right.nil?
    end
    sum
  end
end

tree_name = ENV['NAME']
all_trees = Dir['trees/*.tree']
all_trees.sort!
if tree_name.nil?
  all_trees.each do |name|
    puts name
    arr = JSON.parse(File.open(name.to_s, &:read))
    tree = Tree.new
    tree.insert(arr)
    tree.print_tree
    puts tree.make_decision
    puts 'Желаете продолжить? [y/n]'
    answer = gets.chomp.downcase
    if answer == 'n'
      puts 'Спасибо, что были в нашем лесу'
      break
    end
  end
elsif all_trees.include?('trees/' + tree_name + '.tree')
  string = File.open("trees/#{tree_name}.tree", &:read)
  arr = JSON.parse(string)
  tree = Tree.new
  tree.insert(arr)
  tree.print_tree
else
  puts 'Данное дерево не растет в данном лесу.'
end
puts "\n"
