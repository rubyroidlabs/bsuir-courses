class BinaryTree
  attr_accessor :data, :left, :right, :level, :max

  def initialize(key = nil, lvl = nil)
    @data = nil
    @data = key
    @left = nil
    @right = nil
    @level = lvl
  end

  def create_tree(arr, lvl)
    return BinaryTree.new if arr.nil?
    @data = arr[0]
    @level = lvl
    children = arr[1]
    if (children[0]).is_a?(Array)
      @left = BinaryTree.new(nil, level + 1)
      @left = @left.create_tree(children[0], level + 1)
    elsif children[0].nil?
      @left = BinaryTree.new
    else
      @left = BinaryTree.new(children[0], level + 1)
    end
    if (children[1]).is_a?(Array)
      @right = BinaryTree.new(nil, level + 1)
      @right = @right.create_tree(children[1], level + 1)
    elsif children[1].nil?
      @right = BinaryTree.new
    else
      @right = BinaryTree.new(children[1], level + 1)
    end
    self
  end

  def cut_thehigh
    if @level < 5
      left.cut_thehigh
      right.cut_thehigh
    else
      @left = nil
      @right = nil
    end
  end

  def max_depth(head)
    if !data.nil? && !level.nil?
      if level > head.max
        head.max = level
        left.max_depth(head) if left.class != nil.class
        right.max_depth(head) if right.class != nil.class
      end
    end
  end

  def fake_it(depth)
    if level < depth
      left.fake_it(depth) if left.nil?
      if left.nil?
        left = BinaryTree.new(nil, level + 1)
        left.fake_it(depth)
      end
      right.fake_it(depth) if right.nil?
      if right.nil?
        right = BinaryTree.new(nil, level + 1)
        right.fake_it(depth)
      end
    end
  end

 def add_str(str, maxlevel, lvl, slashline)
   str[0] += spaces(maxlevel, lvl)
   slash = (2**(maxlevel - lvl + 1) - 2) / 2
   buf = spaces(maxlevel, lvl)
   buf[slash] = slashline
   str[1] += buf
 end

  def print_lvl(maxlevel, lvl, str)
    if lvl == 1
      add_str(str, maxlevel, lvl, '/')
      if !data.nil?
        buf = format('%2s', data.to_s)
        str[0] += buf
      elsif left.data.nil?
        str[0] += '  '
        str[1] += '  '
      end
      add_str(str, maxlevel, lvl, '\\')
      return str
    end
    if level < lvl - 1
      str = left.print_lvl(maxlevel, lvl, str)
      str[0] += '  '
      str[1] += '  '
      right.print_lvl(maxlevel, lvl, str)
    elsif level == lvl - 1
      add_str(str, maxlevel, lvl, '/')
      if !left.data.nil?
        buf = format('%2s', left.data.to_s)
        str[0] += buf
        str[1] += '  '
        add_str(str, maxlevel, lvl, '/')
      elsif left.data.nil?
        str[0] += '  '
        str[1] += '  '
        add_str(str, maxlevel, lvl, '\\')
      end
      str[0] += '  '
      str[1] += '  '
      add_str(str, maxlevel, lvl, '/')
      if !right.data.nil?
        buf = format('%2s', right.data.to_s)
        str[0] += buf
        str[1] += '  '
        add_str(str, maxlevel, lvl, '\\')
      elsif right.data.nil?
        str[0] += '  '
        add_str(str, maxlevel, lvl, '\\')
      end
      str
    end
  end

  def print_tree(depth)
    if depth > 6
      depth = 6
      puts 'Это дерево слишком высокое, чтобы поместиться в терминал.' \
      ' Его видимая длина уменьшена до 6.'
    end
    (1..depth).each do |lvl|
      str = Array.new(2)
      str[0] = ''
      str[1] = ''
      str = print_lvl(depth, lvl, str)
      puts str[0]
      puts str[1] if lvl != depth
    end
  end

  def sum_elements(sum = 0)
    sum += data
    sum += left.sum_elements if !left.nil? && !left.data.nil?
    sum += right.sum_elements if !right.nil? && !right.data.nil?
    sum
  end
end
