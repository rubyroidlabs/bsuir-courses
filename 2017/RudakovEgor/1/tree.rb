# Class for binary tree
class Tree
  def initialize(node)
    @node = node
  end

  def left
    if @node.is_a? Array
      Tree.new(@node[1][0])
    else
      nil
    end
  end

  def right
    if @node.is_a? Array
      Tree.new(@node[1][1])
    else
      nil
    end
  end

  def value
    if @node.is_a? Array
      @node[0]
    elsif @node.is_a? Integer
      @node
    else
      nil
    end
  end

  def height
    if left.nil?
      1
    else
      [left.height, right.height].max + 1
    end
  end

  def print_tree
    levels = get_levels
    height = levels.size
    levels.each_with_index do |level, i|
      left_space = 2**(height - i) - 2
      center_space = 2**(height - i + 1) - 2
      if i > 0
        branches_str = ' ' * (left_space + 1)
        is_left = true
        level.each do |value|
          if value
            branches_str += '/' if is_left
            branches_str += '\\' unless is_left
          else
            branches_str += ' '
          end
          branches_str += '¯' * center_space if is_left
          branches_str += ' ' * (center_space + 2) unless is_left
          is_left = !is_left
        end
        puts branches_str
      end
      processed_level = level.map.with_index do |value, j|
        if value.nil?
          value = '  '
        elsif value.digits.count == 1
          value = j.even? ? value.to_s + ' ' : ' ' + value.to_s
        end
        value
      end
      values_str = ' ' * left_space
      values_str += processed_level.join(' ' * center_space)
      puts values_str
    end
  end

  def get_levels
    queue = []
    queue.push(self)
    levels = []
    current_level = 0
    until queue.empty?
      level = []
      elements_count = 2**current_level
      nil_count = 0
      elements_count.times do
        node = queue.shift
        if node.nil?
          nil_count += 1
          level.push(nil)
          break if nil_count == elements_count
          queue.push(nil)
          queue.push(nil)
        else
          level.push(node.value)
          queue.push(node.left)
          queue.push(node.right)
        end
      end
      break if nil_count == elements_count
      levels.push(level)
      current_level += 1
    end
    levels
  end

  def sum_of_nodes
    queue = []
    queue.push(self)
    sum = 0
    until queue.empty?
      node = queue.shift
      sum += node.value
      queue.push(node.left) if node.left
      queue.push(node.right) if node.right
    end
    sum
  end

  def rules
    if self.sum_of_nodes > 5000
      puts 'Cрубить'
    elsif self.height > 5
      puts 'Обрезать'
    else
      puts 'Оставить'
    end
  end
end
