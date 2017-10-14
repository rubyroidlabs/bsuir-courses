# class of binary tree with different methods
class Tree
  attr_accessor :left
  attr_accessor :right
  attr_accessor :value
  attr_accessor :depth
  attr_accessor :sum
  def initialize(value = nil)
    @value = value
    @left = nil
    @right = nil
    @sum = 0
    @depth = 0
  end

  def print_leveled_tree(tree, level, side)
    return if tree.nil?
    print_leveled_tree(tree.right, level + 1, 0)
    puts "#{output_tree_signs(level, side)}#{tree.value} \n"
    print_leveled_tree(tree.left, level + 1, 1)
  end

  def output_tree_signs(level, side)
    str = ''
    level.times { str += '    ' }
    str +=
      if side.zero?
        ' /---'
      elsif side == 2
        ' '
      else
        ' \\---'
      end
  end

  def get_tree_sum(tree)
    return if tree.nil?
    get_tree_sum(tree.left)
    @sum += tree.value
    get_tree_sum(tree.right)
  end

  def rec_arr(tree, tree_arr)
    tree = Tree.new if tree.nil?
    branches_work(tree, tree_arr) if
    !tree_arr[0].is_a?(Array) && tree_arr[1].is_a?(Array)
    return nil if !tree_arr[0].is_a?(Array) && !tree_arr[1].is_a?(Array)
    tree
  end

  def branches_work(tree, tree_arr)
    tree.value = tree_arr[0]
    fill_nodes(tree, tree_arr)
  end

  def fill_nodes(tree, tree_arr)
    tree.left = rec_arr(tree.left, tree_arr[1][0])
    memory_work(tree, tree_arr) if tree.left.nil?
    tree.right = rec_arr(tree.right, tree_arr[1][1])
    memory_work(tree, tree_arr) if tree.right.nil?
  end

  def memory_work(tree, tree_arr)
    tree.left = Tree.new
    tree.right = Tree.new
    tree.left.value = tree_arr[1][0]
    tree.right.value = tree_arr[1][1]
  end

  def get_max_depth(tree, depth)
    if tree.nil?
      depth
    else
      l_depth = get_max_depth(tree.left, depth + 1)
      r_depth = get_max_depth(tree.right, depth + 1)
      @depth = [l_depth, r_depth].max
    end
  end
end
