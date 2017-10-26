class Tree
  attr_reader :root, :sum, :depth, :flag

  def initialize(item)
    @root = Node.new(item)
    @sum = item
    @depth = 1
  end

  def create_and_out(item)
    add_node(item, @root)
    out_tree(@root, @depth)
  end

  def add_node(item, node)
    left = item[0][0]
    right = item[0][1]
    if left.class == Array
      i = left.shift
      node.left = Node.new(i)
      @flag != 1 ? @depth += 1 : @depth
      @sum += i
      add_node(left, node.left)
    else
      node.left = left
      @sum += left
      @flag != 1 ? @depth += 1 : @depth
      @flag = 1
    end
    if right.class == Array
      i = right.shift
      node.right = Node.new(i)
      @sum += i
      add_node(right, node.right)
    else
      node.right = right
      @sum += right
    end
  end

  def get_elem_level(level, root, elems)
    if root.class == Node
      if level.zero?
        elems << root.data
        elems
      end
      elems = get_elem_level(level - 1, root.left, elems)
      elems = get_elem_level(level - 1, root.right, elems)
    elsif level.zero?
      elems << root
    end
    elems
  end

  def out_tree(root, depth)
    counter = (2**(depth + 1) - 2) / 2
    depth.times do |i|
      list = []
      list = get_elem_level(i, root, list)
      counter -= 1
      f_t = counter
      counter /= 2
      s_t = counter
      f_l = counter.zero? ? ' ' * f_t : ' ' * (s_t + 1)
      s_l = ' ' * s_t
      list.each do |j|
        j = j.to_s
        if j.size == 1
          j += ' '
        end
        if s_t != 0 && s_t + 1 != f_t
          buf = f_t - s_t - 1
          f_l += '_' * buf + j + '_' * buf + ' ' * (2 * s_t + 4)
        else
          f_l += j + '  ' * (f_t + 1)
        end
        s_l += '/' + ' ' * f_t + '\\' + ' ' * (f_t + 2)
      end
      puts f_l
      puts s_l if i != depth - 1
    end
    if @sum > 5000
      puts 'Срубить.'
    elsif @depth > 5
      puts 'Обрезать.'
    else
      puts 'Оставить.'
    end
  end
end

class Node < Tree
  attr_accessor :left, :right, :data

  def initialize(item)
    @data = item
  end
end
