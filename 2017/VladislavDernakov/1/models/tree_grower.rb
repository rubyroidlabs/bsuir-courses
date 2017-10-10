require_relative 'tree'

class TreeGrower
  def self.grow(tree_array)
    Tree.new make_tree(tree_array)
  end

  def self.make_tree(array)
    node = Node.new array[0]

    node.left = if array[1][0].is_a?(Numeric)
                  Node.new(array[1][0])
                else
                  make_tree(array[1][0])
                end

    node.right = if array[1][1].is_a?(Numeric)
                   Node.new(array[1][1])
                 else
                   make_tree(array[1][1])
                 end

    node
  end

  private_class_method :make_tree
end
