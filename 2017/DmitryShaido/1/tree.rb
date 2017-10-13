class Tree
  attr_accessor :name, :tree_array, :root, :depth, :sum, :shift_array

  def initialize(name = nil, tree_array = nil)
    @name = name
    @root = Node.new(root)
    @tree_array = tree_array
    @shift_array = shift_array
    @depth = 0
    @sum = 0
  end

  def print_tree
    puts @name
    print_nodes
    do_shift(@tree_array)
    get_data
    think
  end

  def print_nodes(tree_array = @tree_array, prefix = '', more = false)
    if tree_array.is_a? Integer
      print prefix + "#{(more ? ' |— ' : ' \\—')}#{tree_array}" + "\n"
      print_nodes(nil, prefix + (more ? ' | ' : ' '), true)
      print_nodes(nil, prefix + (more ? ' | ' : ' '), false)
    elsif tree_array.is_a? Array
      print prefix + "#{(more ? ' |— ' : ' \\—')}#{tree_array[0]}" + "\n"
      print_nodes(tree_array[1][0], prefix + (more ? ' | ' : ' '), true)
      print_nodes(tree_array[1][1], prefix + (more ? ' | ' : ' '), false)
    end
  end

  def get_data(tree_array = @shift_array, root = @root)
    left = tree_array[0][0]
    right = tree_array[0][1]
    if left.is_a? Array
      new_left = left.shift
      @sum += new_left
      root.left = Node.new(new_left)
      @depth += 1
      get_data(left, root.left)
    elsif left.is_a? Integer
      root.left = left
      @sum += left
      @depth += 1
    end
    if right.is_a? Array
      new_right = right.shift
      @sum += new_right
      root.right = Node.new(new_right)
      get_data(right, root.right)
    elsif right.is_a? Integer
      root.right = right
      @sum += right
    end
  end

  def do_shift(tree_array)
    tree_array.shift
    @shift_array = tree_array
  end

  def think
    if @depth > 5 && @sum <= 5000
      puts 'Обрезать. '
    elsif @sum > 5000
      puts 'Срубить. '
    elsif @depth <= 5 && @sum <= 5000
      puts 'Оставить.'
    end
  end
end

class Node < Tree
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end
