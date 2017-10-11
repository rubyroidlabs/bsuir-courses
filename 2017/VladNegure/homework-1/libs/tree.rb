class Tree

  attr_reader :name, :tree

  def initialize(name:, tree:)
    @name = name
    @tree = tree
    @height = nil
    @max_number = nil
  end

  def print
    (height + 1).times do |i|
      @in_between_string = ''
      @data_string = ''
      print_level(tree, i)
      puts @data_string.rstrip
      puts @in_between_string.rstrip
    end
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

  private

  def print_level(node, level, current_height = 0)
    if current_height == level
      value = data(node)
      value = ' ' * max_number_length if value.nil?
      underscores = underscores_needed(current_height, value)
      spaces = spaces_needed(current_height, value)
      @data_string += value.to_s
      if node.is_a? Array
        @data_string += '_' * underscores
        @data_string += ' ' * spaces
        @in_between_string += '|' + ' ' * (underscores + value.to_s.length - 1) + '\\' + ' ' * (spaces - 1)
      else
        @data_string += ' ' * underscores
        @data_string += ' ' * spaces
        @in_between_string += ' ' * total_space_needed(current_height)
      end
    elsif current_height < level
      print_level(go_left(node), level, current_height + 1)
      print_level(go_right(node), level, current_height + 1)
    end
  end

  def walk_through(node = @tree, current_height = 0)
    @height = current_height if current_height > @height
    return unless node.is_a? Array
    walk_through(go_left(node), current_height + 1)
    walk_through(go_right(node), current_height + 1)
  end

  def data(node)
    if node.is_a? Array
      node.first
    elsif node.nil?
      nil
    else
      node
    end
  end

  def go_left(node)
    node.last.first if node.is_a? Array
  end

  def go_right(node)
    node.last.last if node.is_a? Array
  end

  def total_space_needed(current_height)
    if height - current_height < 0
      0
    else
      (max_number_length + 1) * (2**(height - current_height))
    end
  end

  def underscores_needed(current_height, value)
    total_space_needed(current_height) - total_space_needed(current_height + 1) - value.to_s.length - 1
  end

  def spaces_needed(current_height, value)
    total_space_needed(current_height) - underscores_needed(current_height, value) - value.to_s.length
  end

  def max_number_length
    if @max_number_length.nil?
      @max_number_length = @tree.flatten.max.to_s.length
    end
    @max_number_length
  end
end
