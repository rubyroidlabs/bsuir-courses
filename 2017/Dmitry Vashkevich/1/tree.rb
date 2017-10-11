class Tree
  attr_accessor :array_levels
  def initialize
    @array_levels = []
  end

  def get_level(array_nodes)
    if array_levels.empty?
      array_levels << array_nodes
    end
    level = []
    array_nodes.each do |node|
      if node.nil? || (node.left.nil? && node.right.nil?)
        level << nil
        level << nil
      else
        level << node.left
        level << node.right
      end
    end
    level.each do |node|
      next if node.nil?
      array_levels << level
      get_level(level)
      break
    end
  end

  def show
    sum_nodes = 0
    array_ident = []
    n = 2
    (1..array_levels.size).each do |i|
      array_ident[array_levels.size - i] = n
      n = 2 * (n + 1)
    end
    array_ident << 0
    i = 0
    array_levels.each do |level|
      connection_level = ' ' * ((array_ident[i] + array_ident[i + 1]) / 4)
      nodes_level = ' ' * (array_ident[i] / 2)
      level.each do |node|
        if node.nil?
          nodes_level += format('%2s', nil)
          connection_level += ' ' * ((array_ident[i + 1] + 2) / 2)
          connection_level += ' ' * (array_ident[i + 1] * 3 / 2 + 3)
        else
          sum_nodes += node.weight
          nodes_level += format('%2s', node.weight)
          if node.left.nil? && node.right.nil?
            connection_level += ' ' * ((array_ident[i + 1] + 2) / 2)
            connection_level += ' ' * (array_ident[i + 1] * 3 / 2 + 3)
          else
            connection_level += '/' + ' ' * ((array_ident[i + 1] + 2) / 2)
            connection_level += '\\' + ' ' * (array_ident[i + 1] * 3 / 2 + 1)
          end
        end
        nodes_level += ' ' * array_ident[i]
      end
      puts nodes_level
      puts connection_level
      i += 1
    end
    if sum_nodes > 5000
      puts 'Срубить'
    elsif array_levels.size > 5
      puts 'Обрезать'
    else
      puts 'Оставить'
    end
  end
end
