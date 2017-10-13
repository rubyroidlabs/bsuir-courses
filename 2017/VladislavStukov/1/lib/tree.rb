require_relative 'node.rb'

class Tree
  def initialize(array)
    @root = make_tree(array)
  end

  def make_tree(array)
    if array.is_a?(Integer)
      Node.new(array)
    else
      Node.new(array[0], make_tree(array[1][0]), make_tree(array[1][1]))
    end
  end

  def divide_by_level
    @tree_divided_by_level = Array.new
    deep = 0
    @tree_divided_by_level[deep] = Array.new
    @tree_divided_by_level[deep] << @root
    go_deep(@root, deep)
    @tree_divided_by_level.pop if @tree_divided_by_level.last.empty?
  end

  def go_deep(node, deep)
    deep += 1
    @tree_divided_by_level[deep] ||= Array.new
    if node.left
      @tree_divided_by_level[deep] << node.left
      go_deep(node.left, deep)
    end
    if node.right
      @tree_divided_by_level[deep] << node.right
      go_deep(node.right, deep)
    end
  end

  def show_tree
    divide_by_level
    num_of_spaces = (2**@tree_divided_by_level.size - 1) / 2
    @tree_divided_by_level.each do |array|
      space = '  ' * num_of_spaces
      (array.count / 2).times do
        print space
        print '--' * (num_of_spaces * 2 + 3)
        print space + '  '
      end
      puts
      array.each do |node|
        print space
        if node.value < 10
          print node.value.to_s + ' '
        else
          print node.value.to_s
        end
        print space + '  '
      end
      puts
      num_of_spaces /= 2
    end
  end

  def get_sum(node = @root, sum = 0)
    return 0 unless node
    sum += get_sum(node.left, sum) + get_sum(node.right, sum)
    sum + node.value
  end

  def get_max_deep(node = @root, deep = 0)
    return deep unless node
    deep += 1
    left_deep = get_max_deep(node.left, deep)
    right_deep = get_max_deep(node.right, deep)
    [left_deep, right_deep].max
  end

  def check
    if get_sum > 5000
      puts 'Срубить.'
    elsif get_max_deep > 5
      puts 'Обрезать.'
    else
      puts 'Оставить.'
    end
  end
end
