class Node
  attr_accessor :data, :left, :right

  def initialize(x = nil)
    @data = x
    @left = nil
    @right = nil
  end

  def grow_tree(array)
    self.data = array[0]
    subtree = array[1]
    if subtree[0].class == nil.class
      return
    elsif subtree[0].class == array.class
      @left = Node.new.grow_tree(subtree[0])
    else
      @left = Node.new(subtree[0])
    end
    if subtree[1].class == nil.class
      return
    elsif subtree[1].class == array.class
      @right = Node.new.grow_tree(subtree[1])
    else
      @right = Node.new(subtree[1])
    end
    return self
  end




  def tree_to_array(lvl:, depth:0, array:)
    spaces = get_spaces(lvl)
    string = spaces + @data.to_s + spaces
    array[lvl-1] += string
    if @left.class == nil.class && @right.class == nil.class
      return
    else
      left_lvl = @left.get_tree_lvl
      @left.tree_to_array(lvl:left_lvl, depth:left_lvl, array:array)
      right_lvl = @right.get_tree_lvl
      @right.tree_to_array(lvl:right_lvl, depth:left_lvl, array:array)
    end 
    array 
  end

  def get_tree_lvl(lvl = 0)
    lvl += 1
    if @left.class == nil.class
      return lvl
    else
      @left.get_tree_lvl(lvl)
    end
  end

  def get_spaces(lvl)
    return '  ' * lvl 
  end

  def show_tree
    tree_lvl = self.get_tree_lvl
    a = Array.new(tree_lvl,'')
    a = self.tree_to_array(lvl:tree_lvl,depth:tree_lvl ,array:a)
    a.each do |element|
    printf element
    printf "\n"
    end
  end
end

if ENV['NAME'] == nil
  answer = 'y'
  home_dir = ENV['HOME']
  home_dir += '/trees/*tree'
  files = Dir[home_dir]
  list = []
  files.each do |value|
    list.push(value)
  end
  list.each do |filename|
    if answer == 'y'
      fn = open filename
      content = fn.read
      fn.close
      array = eval content
      tree = Node.new.grow_tree(array)
      tree.show_tree
      puts 'do you want to go deeper into the forest? '
      answer = gets.chomp
    else
      puts 'thanks for stiking around'
      break
    end
  end
else
  filename = 'trees/' + ENV['NAME'] + '.tree'
  fn = open filename
  content = fn.read
  fn.close
  array = eval content
  tree = Node.new.grow_tree(array)
  tree.show_tree
end
