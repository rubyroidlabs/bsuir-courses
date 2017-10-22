require 'json'
require 'pry'

class Tree

  attr_accessor :file_name, :tree, :left, :rigth, :node, :value, :root

  def initialize(tree = nil)
    @tree = tree
    @left = left
    @rigth = rigth
    @node = node
    @value = value
    @root = Node.new(@json)
  end

  def main

    links = []
    sol=''

    file = Dir['./trees/*.tree']
    file.each do |file_name|
      links << file_name unless File.directory? file_name
    end

    if ENV['NAME'].nil?
      links.each do |file_name|
        read(file_name)
        tree_name = 'trees/' + @name + '.tree'
        arr = tree_name.scan(/\d\d*/)
        str = tree_name.delete '0-9'
        tree_node(@json, @root)
        binding.pry
        tree = []
        create(arr, str)
        level = 0
        level = get_tree_level(arr)
        max_vertex = arr.size
        tree_show(tree, level, max_vertex)
        puts
        puts @name
        puts
        puts @json
        puts
        print 'Желаете продолжить? [y\n]'
        sol = gets.chomp
        break if sol == 'n'
      end
    elsif ENV['NAME']
      links.each do |file_name|
        if file_name.nil?
          puts 'Безымянных деревьев у нас не растет!'
          break
        end
        if file_name.include? ENV['NAME']
          read(file_name)
          puts
          puts @name
          puts
          puts @json
          puts
        else
          next
        end
      end
    end
  end

  def read(file_name)
    @name = File.basename(file_name)
    @json =JSON.parse(File.read(file_name))
    @name = File.basename(file_name, ".tree")
    @json
  end

  def tree_node(tree_item, node)
    @left = tree_item[0][0]
    @right = tree_item[0][1]
    if @left.class == Array
      node.left = Node.new(@left.shift)
      tree_node(@left, node.left)
    else
      node.left = @left
    end
    if @right.class == Array
      node.right = Node.new(@right.shift)
      tree_node(@right, node.right)
    else
      node.right = @right
    end
  end

  def create(arr, str)
    vertex = 1
    i = 0
    j = 0
    tree = []
    tree[vertex] = arr[j]
    while i < str.size - 1
      if str[i] + str[i + 1] == ',['
        vertex *= 2
        unless tree[vertex * 2].nil?
          vertex += 1
        end
        j += 1
        tree[vertex] = arr[j]
      elsif str[i] == ','
        vertex += 1
        j += 1
        tree[vertex] = arr[j]
      elsif str[i] == ']'
        if !tree[vertex * 2].nil? && tree[(vertex * 2) + 1].nil?
          vertex *= 2
        end
        vertex /= 2
      end
      i += 1
    end
    tree
  end

  def get_tree_level(arr)
    size = arr.size
    level = 0
    while size != 0
      level += 1
      size /= 2
    end
    level
  end

  def tree_show(tree, level, max_vertex)
    i = 1
    vertex = 1
    max_vertex -= 1
    while max_vertex != 0
      print ' ' * (max_vertex - 1)
      met = 0
      while met != i
        print tree[vertex]
        if tree[vertex].to_i < 10
          print ' ' * (2**(level + 1) - 1)
        else
          print ' ' * (2**(level + 1) - 2)
        end
        vertex += 1
        met += 1
      end
      i *= 2
      max_vertex /= 2
      level -= 1
      print "\n\n"
    end
  end


end

class Node < Tree

  attr_accessor :left, :right, :data

  def initialize(tree_item)
    @data = tree_item
  end
end

Tree.new.main
puts 'Спасибо, что были в нашем лесу!'

