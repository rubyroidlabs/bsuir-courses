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
        tree_node(@json, @root)
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

end

class Node < Tree

  attr_accessor :left, :right, :data

  def initialize(tree_item)
    @data = tree_item
  end
end

Tree.new.main
puts 'Спасибо, что были в нашем лесу!'

