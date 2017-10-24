# Node class for Tree ((RubyCop))
class Node
  attr_accessor :value, :left, :right
  def initialize(value = nil)
    @value = value
    @right = nil
    @left = nil
    @sum = 0
  end

  def insert(node, value)
    if node.nil?
      node = Node.new(value)
    elsif value < node.value
      node.left = insert(node.left, value)
    elsif value > node.value
      node.right = insert(node.right, value)
    elsif value == node.value
      node.value = value
    end
    node
  end

  def sum(node)
    return 0 if node.nil?
    sum(node.left)
    @sum += node.value
    sum(node.right)
  end

  def max_depth(node)
    return 0 if node.nil?
    left = max_depth(node.left)
    right = max_depth(node.right)
    left > right ? left + 1 : right + 1
  end

  def check(node)
    if max_depth(node) > 5
      puts 'Слишком высокое, нужно обрезать'
    elsif sum(node) > 5000
      puts 'Слишком старое, нужно рубить'
    else
      puts 'Нормальное дерево'
    end
  end

  # def print(node); end
end
