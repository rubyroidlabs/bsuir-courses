require_relative 'node'

class Tree

  SEPARATOR = ' '

  attr_accessor :root

  def initialize(root)
    @root = root
  end

  def show
    levels = divide_into_levels
    depth  = levels.size
    
    levels.each_with_index do |level, level_index|
      left_indent = 2**(depth - level_index) - 2
      between_indent = 2**(depth - level_index + 1) - 2

      # if current level is not first 
      if level_index > 0
        connections_str = SEPARATOR * (left_indent + 1)
        is_left = true
        level.each do |value|
          if value
            connections_str += '/' if is_left
            connections_str += '\\' if !is_left
          else 
            connections_str += ' '
          end
          connections_str += SEPARATOR * between_indent if is_left
          connections_str += SEPARATOR * (between_indent + 2) if !is_left
          is_left = !is_left
        end
        puts connections_str
      end

      processed_level = level.map.with_index do |value, index|
        if value.nil?
          value = '  '
        elsif value.digits.count == 1
          value = index.even? ? value.to_s + ' ' : ' ' + value.to_s
        end
        value
      end
      values_str = SEPARATOR * left_indent
      values_str += processed_level.join(SEPARATOR * between_indent)
      puts values_str
    end
  end

  def sum_of_nodes
    queue = []
    queue.push(@root)
    sum = 0
    until queue.empty?
      node = queue.shift
      sum += node.value
      queue.push(node.left) if node.left
      queue.push(node.right) if node.right
    end
    sum
  end

  def depth
    levels = divide_into_levels
    levels.count
  end

  private

  def divide_into_levels
    queue = []
    queue.push(@root)

    levels = []
    current_level = 0

    until queue.empty?
      level = []

      elements_count = 2**current_level
      nil_count = 0

      elements_count.times do
        node = queue.shift
        
        if node == nil 
          nil_count += 1
          level.push(nil)
          break if nil_count == elements_count
          queue.push(nil)
          queue.push(nil)
        else 
          level.push(node.value)
          queue.push(node.left ? node.left : nil)
          queue.push(node.right ? node.right : nil)
        end
      end
      break if nil_count == elements_count
      levels.push(level)
      current_level += 1
    end
    levels
  end
end
