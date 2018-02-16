class Tree
  attr_reader :new_array
  def initialize
    @new_array = []
  end

  def create(array, level = 0)
    if array[0].class.to_s == 'Integer' && array[1].class.to_s == 'Integer'
      check_array(level)
      @new_array[level].push(array[0])
      @new_array[level].push(array[1])
    elsif array[0].class.to_s == 'Integer'
      check_array(level)
      @new_array[level].push(array[0])
      level += 1
      create(array[1], level)
    elsif array[1].class.to_s == 'Integer'
      check_array(level)
      @new_array[level].push(array[1])
      level += 1
      create(array[0], level)
    else
      create(array[0], level)
      create(array[1], level)
    end
  end

  def print(margin = '  ')
    str = Array.new(@new_array.count) { '' }
    slash = Array.new(@new_array.count) { '' }
    old = new = ''
    @new_array = @new_array.reverse
    @new_array.each do |first|
      index = 0
      while index < 2**@new_array.index(first)
        new += margin
        index += 1
      end
      index = 0
      first.each do |element|
        str[@new_array.index(first)] += space(old, new, index, element, first)
        element = add_slash(index)
        slash[@new_array.index(first)] += space(old, new, index, element, first)
        index += 1
      end
      old = new
    end
    print_tree(str.reverse, slash.reverse)
  end

  private def print_tree(tree, slash)
    i = 0
    while i < tree.count
      puts tree[i]
      puts slash[i + 1]
      i += 1
    end
  end

  def check_array(level)
    return if @new_array[level].class.to_s == 'Array'
    @new_array[level] = []
  end

  def two_space_for_number(element)
    if element.to_s.size == 1
      ' ' + element.to_s
    else
      element.to_s
    end
  end

  def add_slash(index)
    if index.even?
      ' /'
    else
      '\ '
    end
  end

  def space(old, new, index, element, first_level_element)
    part = new + two_space_for_number(element)
    if index.zero?
      part = old + two_space_for_number(element)
    elsif index == first_level_element.count - 1
      part = new + two_space_for_number(element) + old
    end
    part
  end
end
