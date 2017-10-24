class TreeNode
  def initialize
    @left_node = nil
    @right_node = nil
    @value = 0
    @depth = 0
  end

  attr_accessor :depth, :value, :left_node, :right_node

  def create_left_node
    @left_node = TreeNode.new
  end

  def create_right_node
    @right_node = TreeNode.new
  end
end
