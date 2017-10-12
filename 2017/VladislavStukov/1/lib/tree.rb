require_relative 'node.rb'

class Tree

  def initialize(array)
    if array[0] != nil
      @root = make_tree(array)
    end
    @sum = 0
    @max_deep = 0
  end

  def make_tree(array)

    if array.is_a?(Integer)
      Node.new(array)
    else
      Node.new(array[0], make_tree(array[1][0]), make_tree(array[1][1]));
    end

  end



  def divide_by_level

    @q = Array.new
    deep = 0

    @q[deep] = Array.new
    @q[deep] << @root
    go_deep(@root, deep)

    if @q.last.empty?
      @q.pop
    end
  end

  def go_deep(node, deep)
    deep += 1

    if @q[deep].is_a?(NilClass)
      @q[deep] = Array.new
    end

    if node.left.nil?
      nil
    else
      @q[deep] << node.left
      go_deep(node.left, deep)
    end

    if node.right.nil?
      nil
    else
      @q[deep] << node.right
      go_deep(node.right, deep)
    end

  end

  def show_tree

    self.divide_by_level

    num_of_spaces = (2 ** @q.size - 1) / 2


    @q.each do |array|

      space = '  ' * num_of_spaces

      (array.count / 2).times do
        print space
        print  '--' * (num_of_spaces * 2 + 3)
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

  def get_sum(node = @root)
    if node.nil?
      return
    end
    if node.left == nil && node.right == nil
      @sum += node.value
    else
      @sum += node.value
      get_sum(node.left)
      get_sum(node.right)
    end

    @sum
  end



  def get_max_deep(node = @root, deep = 0)
    if node.nil?
      return 0
    end

    deep += 1
    deep > @max_deep ? @max_deep = deep : nil
    get_max_deep(node.left, deep)
    get_max_deep(node.right, deep)

    @max_deep

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
