class TreeOutputBuilder
  def initialize(tree, height)
    @height = height
    @max_number_length = max_number_length(tree)
  end

  def data_string(node, level)
    initialize_variables_for_level(node, level)
    if node.is_a? Array
      data_string_for_node
    else
      data_string_for_value
    end
  end

  def connection_string(node, level)
    initialize_variables_for_level(node, level)
    if node.is_a? Array
      connection_string_for_node
    else
      connection_string_for_value
    end
  end

  private

  def initialize_variables_for_level(node, level)
    @level = level
    @value = get_node_value(node)
    @underscores = underscores_needed(level, @value)
    @spaces = spaces_needed(level, @value)
  end

  def data_string_for_node
    @value + '_' * @underscores + ' ' * @spaces
  end

  def data_string_for_value
    @value + ' ' * @underscores + ' ' * @spaces
  end

  def connection_string_for_node
    '|' + ' ' * (@underscores + @value.length - 1) + '\\' + ' ' * (@spaces - 1)
  end

  def connection_string_for_value
    ' ' * total_space_needed(@level)
  end

  def total_space_needed(level)
    if level <= @height
      (@max_number_length + 1) * (2**(@height - level))
    else
      0
    end
  end

  def underscores_needed(level, value)
    total_space_needed(level) - total_space_needed(level + 1) - value.length - 1
  end

  def spaces_needed(level, value)
    total_space_needed(level) - underscores_needed(level, value) - value.length
  end

  def get_node_value(node)
    if node.is_a? Array
      node.first.to_s
    elsif node.nil?
      ' ' * @max_number_length
    else
      node.to_s
    end
    # case node.class  why doesn't it work?
    # when Array
    #   node.first.to_s
    # when NilClass
    #   ' ' * @max_number_length
    # else
    #   node.to_s
    # end
  end

  def max_number_length(tree)
    @max_number_length = tree.flatten.max.to_s.length
  end
end
