class Tree
  attr_accessor :depth, :root, :sum_nodes

  def initialize(v)
    @root = Node.new(v)
    @depth = 0
    @sum_nodes = 0
  end

  def wp(elem)
    elem = elem.to_s
    if elem.length == 1
      elem = ' ' + elem
    end
    elem
  end

  def create_tree(arr)
    add_node(@root, arr)
    depth_of_tree(@root)
    get_sum_nodes(@root)
  end

  def depth_of_tree(root)
    if root.class == Node
      @depth += 1
      depth_of_tree(root.left)
    end
  end

  def add_node(node, arr)
    left = arr[0][0]
    right = arr[0][1]
    if left.class == Array
      node.left = Node.new(left.shift)
      add_node(node.left, left)
    else
      node.left = left
    end
    if right.class == Array
      node.right = Node.new(right.shift)
      add_node(node.right, right)
    else
      node.right = right
    end
  end

  def get_elems(root, level, list)
    if root.nil?
    elsif root.class == Node
      get_elems(root.left, level - 1, list)
      list << root.value if level.zero?
      get_elems(root.right, level - 1, list)
    elsif level.zero?
      list << root
    end
    list
  end

  def print_tree
    spaces = 2**(@depth + 1)
    (@depth + 1).times do |level|
      list = []
      get_elems(@root, level, list)
      str = ''
      str2 = ''
      spaces1 = spaces / 2**level - 1
      list.each do |elem|
        str += ' ' * spaces1 + wp(elem) + ' ' * spaces1
        str2 += ' ' * (spaces1 - 1) + '/  \\' + ' ' * (spaces1 - 1)
      end
      puts str
      puts str2 unless level == @depth
    end
    if @sum_nodes > 5000
      puts 'Срубить.'
    elsif @depth > 5
      puts 'Обрезать.'
    else
      puts 'Оставить.'
    end
  end

  def get_sum_nodes(root)
    if root.class == Node
      @sum_nodes += root.value
      get_sum_nodes(root.left)
      get_sum_nodes(root.right)
    end
  end
end

class Node < Tree
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
  end
end
