class Tree
  def initialize
    @tree_root = nil
  end

  attr_reader :tree_root

  def initialization(array, code, tree_node, depth)
    if check_valid_number(array) && code.zero?
      tree_node.value = array
      tree_node.depth = depth
      return
    end

    if code == 1
      if array[0]
        initialization(array[0], 0, tree_node.create_left_node, depth + 1)
      end
      if array[1]
        initialization(array[1], 0, tree_node.create_right_node, depth + 1)
      end
    else
      if array[0] && check_valid_number(array[0])
        tree_node.value = array[0]
        tree_node.depth = depth
      end

      if array[1]
        initialization(array[1], 1, tree_node, depth)
      end
    end
  end

  def check_valid_number(elem)
    elem.to_s.each_char do |index|
      unless (48..57).cover?(elem.to_s[index].ord)
        return false
      end
    end
    true
  end

  def create_root
    @tree_root = TreeNode.new
  end

  def get_max_depth(tree_root)
    max_depth = tree_root.depth
    if tree_root.left_node
      current_depth = get_max_depth(tree_root.left_node)
      if current_depth > max_depth
        max_depth = current_depth
      end
    end

    if tree_root.right_node
      current_depth = get_max_depth(tree_root.right_node)
      if current_depth > max_depth
        max_depth = current_depth
      end
    end
    max_depth
  end

  def check_depth(tree_root)
    if get_max_depth(tree_root) > 5
      false
    else
      true
    end
  end

  def count_sum_nodes(tree_root)
    sum = 0
    if tree_root
      sum = tree_root.value
    end

    if tree_root.left_node
      sum += count_sum_nodes(tree_root.left_node)
    end

    if tree_root.right_node
      sum += count_sum_nodes(tree_root.right_node)
    end
    sum
  end

  def crop(tree_root)
    if tree_root && tree_root.depth > 5
      return false
    end

    if tree_root.left_node
      unless crop(tree_root.left_node)
        tree_root.left_node = nil
      end
    end

    if tree_root.right_node
      unless crop(tree_root.right_node)
        tree_root.right_node = nil
      end
    end
    true
  end

  def output_level(tree_root, level, current_depth)
    if tree_root.depth == level
      print ' ' * (4 * current_depth).to_i
      print tree_root.value.to_s
      print ' ' * (current_depth * 4 - tree_root.value.to_s.size).to_i
    end
    if tree_root.left_node
      output_level(tree_root.left_node, level, current_depth)
    end

    if tree_root.right_node
      output_level(tree_root.right_node, level, current_depth)
    end
  end

  def get_tree(tree_root)
    level = 1
    max_depth = get_max_depth(tree_root) + 1
    while level < max_depth
      current_depth = 2**(max_depth - level - 2)
      output_level(tree_root, level,  current_depth)
      print "\n"
      level += 1
    end
  end
end

