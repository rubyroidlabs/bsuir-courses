class Tree
  attr_accessor :value, :left, :right
  def initialize(value = nil, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end

  def self.make_tree(array)
    tree = Tree.new(array[0])
    if array[1][0].is_a?(Numeric)
      tree.left = Tree.new(array[1][0])
    else
      tree.left = make_tree(array[1][0])
    end
    if array[1][1].is_a?(Numeric)
      tree.right = Tree.new(array[1][1])
    else
      tree.right = make_tree(array[1][1])
    end
    tree
  end
end
class Root
  attr_accessor :tree, :hight, :mass, :bool, :index
  def initialize
    @index = 0
    @bool = true
    @hight = 1
  end

  def do_array(tree)
    @mass[@index].push(tree.value)
    unless tree.left.nil?
      @index += 1
      do_array(tree.left)
    end
    unless tree.right.nil?
      @index += 1
      do_array(tree.right)
    end
    @index -= 1
  end

  def do_hight(tree)
    unless tree.left.nil?
      if @bool
        @hight += 1
      end
      do_hight(tree.left)
    end
    unless tree.right.nil?
      if @bool
        @hight += 1
      end
      do_hight(tree.right)
    end
    @bool = false
    @hight
  end

  def output
    i = 0
    l = 0
    while i < @mass[@hight - 1].size
      l += @mass[@hight - 1][i].to_s.length
      i += 1
    end
    l += @mass[@hight - 1].size
    i = 0
    while i < @hight
      j = 0
      string = ''
      while j < @mass[i].size
        s2 = space(l)
        string = string + s2 + @mass[i][j].to_s + s2
        j += 1
      end
      puts string
      l /= 2
      i += 1
    end
  end

  def space(length)
    i = 1
    s = ' '
    while i < length
      s += ' '
      i += 1
    end
    s
  end

  def main
    require 'json'
    file = 'trees/' + ENV['NAME'] + '.tree'
    if ENV['NAME'] = nil
      puts 'Пустых деревьев не растет'
    elsif File.file? file
      @tree = Tree.make_tree(JSON.parse(File.read(file)))
      do_hight(@tree)
      @mass = Array.new(@hight) { [] }
      do_array(@tree)
      output
    else
      puts 'Такого дерева не растет'
    end
  end
end
Root.new.main
