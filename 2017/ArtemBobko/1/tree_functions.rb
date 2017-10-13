class Tree
  def self.print_tree(array, prefix = '', is_left = false)
    if array.is_a?  Fixnum
      puts "#{prefix}#{(is_left ? "|-- " : "\\-- ")}#{array}"
      print_tree(nil, prefix + (is_left ? "|   " : "    "), true)
      print_tree(nil, prefix + (is_left ? "|   " : "    "), false)
    elsif array.is_a? Array
      puts "#{prefix}#{(is_left ? "|-- " : "\\-- ")}#{array[0]}"
      print_tree(array[1][0], prefix + (is_left ? "|   " : "    "), true)
      print_tree(array[1][1], prefix + (is_left ? "|   " : "    "), false)
    end
  end

  def self.sum(node)
    if node.nil? || node[0].nil?
      return 0
    elsif node.is_a?  Fixnum
      return node
    elsif node.is_a? Array
      return node[0] + sum(node[1][0]) + sum(node[1][1])
    end
  end

  def self.height(node)
    if node.nil? || node[0].nil?
      return 0
    elsif node.is_a? Fixnum
      return 1
    elsif node.is_a? Array
      return [height(node[1][0]), height(node[1][1])].max + 1
    end
  end

  def self.cut(array, lvl=1)
    if (array.is_a? Array) && (array[1][0].class != Fixnum) 
      cut(array[1][0], lvl + 1)
    end
    if (array.is_a? Array) && (array[1][1].class != Fixnum)
      cut(array[1][1], lvl + 1)
    end
    if (array[1][0].is_a? Fixnum) &&  (lvl + 1 > 5)
        array[1][0] = nil
    end
    if (array[1][1].is_a? Fixnum) && (lvl + 1 > 5)
        array[1][1] = nil
    end
    if(lvl > 5)
      array[0] = nil
    end
  end
end