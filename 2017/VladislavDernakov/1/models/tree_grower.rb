require_relative "tree"

class TreeGrower
	def self.grow(tree_array)
		Tree.new self.make_tree(tree_array)
	end

	private

	def self.make_tree(array)
		node = Node.new array[0]
		node.left  = array[1][0].is_a?(Numeric) ? Node.new(array[1][0]) : make_tree(array[1][0])
		node.right = array[1][1].is_a?(Numeric) ? Node.new(array[1][1]) : make_tree(array[1][1])
		node
	end
end