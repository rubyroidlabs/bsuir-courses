# class for work with tree
class Tree
  def self.print_tree(array, prefix = '', is_left = false)
    if array.is_a? Integer
      put_str(array, prefix, is_left)
    elsif array.is_a? Array
      put_str(array[0], prefix, is_left)
      print_tree(array[1][0], prefix + (is_left ? '|   ' : '    '), true)
      print_tree(array[1][1], prefix + (is_left ? '|   ' : '    '), false)
    end
  end

  def self.put_str(number, prefix = '', is_left = false)
    puts "#{prefix}#{(is_left ? '|-- ' : '\\-- ')}#{number}"
  end

  def self.sum(node)
    if node.nil? || node[0].nil?
      0
    elsif node.is_a? Integer
      node
    elsif node.is_a? Array
      node[0] + sum(node[1][0]) + sum(node[1][1])
    end
  end

  def self.height(node)
    if node.nil? || node[0].nil?
      0
    elsif node.is_a? Integer
      1
    elsif node.is_a? Array
      [height(node[1][0]), height(node[1][1])].max + 1
    end
  end

  def self.cut(node, lvl = 1)
    node[1].map { |e| cut(e, lvl + 1) if e.is_a? Array } if node.is_a? Array
    node[1] = check_integer(node[1]) if lvl + 1 > 5
    node[0] = check_array(node[0]) if lvl > 5
  end

  def self.check_array(e)
    if e.is_a? Array
      nil
    else
      e
    end
  end

  def self.check_integer(a)
    a.map { |e| nil if e.is_a? Integer }
  end
end
