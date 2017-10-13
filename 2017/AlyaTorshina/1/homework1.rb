require 'json'

class Tree
  attr_accessor :depth, :root, :sum, :elements

  def initialize(root)
    @root = Node.new(root)
    @root.level = 1
    @depth = 0
    @sum = 0   
  end

  def create(arr)
    @elements = [[@root.level, @root.value]]
    add_node @root, arr
    print_list
    check_attributes
  end  

  def add_node(node, arr)
    left = arr[0][0]
    right = arr[0][1]
    if left.class.equal?Array
      node.left = Node.new(left.shift)
      node.left.root = node
      check_level node.left, node.left
      @elements.push [node.left.level, node.left.value] 
      @sum += node.left.value
      add_node node.left, left   
    elsif left.class.equal?Integer 
      node.left = Node.new(left)
      node.left.root = node
      check_level node.left, node.left
      @elements.push [node.left.level, node.left.value] 
      @sum += node.left.value   
    end  
    if right.class.equal?Array
      node.right = Node.new(right.shift)
      node.right.root = node
      check_level node.right, node.right
      @elements.push [node.right.level, node.right.value] 
      @sum += node.left.value
      add_node node.right, right 
    elsif right.class.equal?Integer
      node.right = Node.new(right)
      node.right.root = node
      check_level node.right, node.right
      @elements.push [node.right.level, node.right.value] 
      @sum += node.left.value    
    end   
  end

  def check_level(current_node, next_node)
    link = next_node.root
    continue = true
    if link.equal?(@root)
      continue = false
    end
    if continue
      current_node.level += 1
      check_level current_node, link
    end    
  end   
  
  def check_attributes 
    @elements.each do |item| 
      if @depth < item[0]
        @depth = item[0]
      end
    end
    if @sum > 5000
      puts 'Срубить'
    elsif @depth > 5
      puts 'Обрезать'  
    else
      puts 'Оставить'  
    end 
  end

  def print_list
    str = ['', '', '', '', '']
    @elements.each do |item|
      if item[0] - 1 < 5
        str[item[0]-1] << "#{item[1]} " 
      end 
    end 
    str.each { |item| puts item }
  end
end

class Node
  attr_accessor :left, :right, :value, :root, :level

  def initialize(value)
    @value = value
    @level = 2
    @left = nil
    @right = nil
    @root = nil
  end
end

files = []
Dir['trees/*.tree'].sort.each do |filename|
  filename.slice!(0..5) 
  files.push(filename)
end 
if ENV['NAME'].nil?
  answer = ''
  files.each do |filename|
    puts 'Дерево: ' + filename
    content = File.read('trees/' + filename)
    input = JSON.parse(content)
    our_tree = Tree.new(input.shift)
    our_tree.create input
    print 'Желаете продолжить? [y/n] : '
    answer = gets
    if answer[0] == 'n'
      puts 'Спасибо что были в нашем лесу.'
      break
    end
    if answer[0] != 'y'
      puts 'Вы ввели неправильный ответ. Спасибо что были в нашем лесу.'  
      break
    end  
  end
elsif files.include?(ENV['NAME'] + '.tree')
  filename = ENV['NAME'] + '.tree'
  puts 'Дерево: ' + filename
  content = File.read('trees/' + filename)
  input = JSON.parse(content)
  our_tree = Tree.new(input.shift)
  our_tree.create input
else 
  puts 'Данное дерево не растет в данном лесу.'
end
