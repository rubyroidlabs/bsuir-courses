require_relative 'tree_output_builder'

class Tree
  attr_reader :name, :tree

  def initialize(name, tree)
    @name = name
    @tree = tree
    @height = nil
  end

  def height
    if @height.nil?
      @height = 0
      walk_through(tree)
    end
    @height
  end

  def age
    @tree.flatten.inject(0, :+)
  end

  def draw
    tree_output_builder = TreeOutputBuilder.new(tree, height)
    (height + 1).times do |level|
      data_string = ''
      connection_string = ''
      go_through_level(level) do |node|
        data_string += tree_output_builder.data_string(node, level)
        connection_string += tree_output_builder.connection_string(node, level)
      end
      puts data_string + "\n" + connection_string
    end
  end

  private

  def go_through_level(level, node = @tree, current_level = 0, &block)
    if current_level == level
      yield(node) if block_given?
    elsif current_level < level
      go_to_next_level(level, node, current_level, &block)
    end
  end

  def go_to_next_level(level, node, current_level, &block)
    go_through_level(level, go_left(node), current_level + 1, &block)
    go_through_level(level, go_right(node), current_level + 1, &block)
  end

  def walk_through(node, current_level = 0)
    @height = current_level if current_level > @height
    if node.is_a? Array
      walk_through(go_left(node), current_level + 1)
      walk_through(go_right(node), current_level + 1)
    end
  end

  def go_left(node)
    node.last.first if node.is_a? Array
  end

  def go_right(node)
    node.last.last if node.is_a? Array
  end
end
