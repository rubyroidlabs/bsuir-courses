require 'json'

class Tree
  attr_accessor :depth, :root, :sum, :elements, :str, :str2

  def initialize(root)
    @root = Node.new(root)
    @root.level = 1
    @depth = 0
    @sum = 0
  end

  def create(arr)
    @elements = [[@root.level, @root.value]]
    add_node(@root, arr)
    conclusion = check_attributes
    @str = Array.new(@depth, '')
    @str2 = Array.new(@depth, '')
    create_output(@root)
    i = 0
    @depth.times do 
      puts @str[i]
      puts @str2[i]
      i += 1
    end  
    puts conclusion
  end

  def add_node(node, arr)
    left = arr[0][0]
    right = arr[0][1]
    if left.instance_of? Array
      left_links(node, left.shift)
      attributes(node.left)
      add_node(node.left, left)
    elsif left.instance_of? Integer
      left_links(node, left)
      attributes(node.left)
    end
    if right.instance_of? Array
      right_links(node, right.shift)
      attributes(node.right)
      add_node(node.right, right)
    elsif right.instance_of? Integer
      right_links(node, right)
      attributes(node.right)
    end
  end
  
  def left_links(node, left)
    node.left = Node.new(left)
    node.left.root = node
  end
  
  def right_links(node, right)
    node.right = Node.new(right)
    node.right.root = node
  end
  
  def attributes(node)
    check_level(node, node)
    @elements.push([node.level, node.value])
    @sum += node.value
  end

  def check_level(current_node, next_node)
    link = next_node.root
    unless link.equal?(@root)
      current_node.level += 1
      check_level(current_node, link)
    end
  end

  def check_attributes
    @elements.each do |item|
      if @depth < item[0]
        @depth = item[0]
      end
    end
    if @sum > 5000
      'Срубить'
    elsif @depth > 5
      'Обрезать'
    else
      'Оставить'
    end
  end

  def create_output(node)
    if node.root != nil
      if node.root.left.equal? node
        @str2[node.level - 2] += '|'
      else
        @str2[node.level - 2] += "\\ " + '  '
      end
    end
    @str[node.level - 1] += node.value.to_s + ' '
    if node.left != nil
      create_output(node.left)
    end
    if node.right != nil  
      create_output(node.right)
    end
  end
end

class Node
  attr_accessor :left, :right, :value, :root, :level

  def initialize(value)
    @value = value
    @level = 2
    # Дополнительные узлы, отличные от корня дерева, имеют уровень >= 2
  end
end

class Console
  
  def initialize(name)
    @files = []
    @name = name
  end
  
  def tree_output(filename)
    puts 'Дерево: ' + filename
    content = File.read('trees/' + filename)
    input = JSON.parse(content)
    our_tree = Tree.new(input.shift)
    our_tree.create(input)
  end
  
  def input_output
    Dir['trees/*.tree'].sort.each do |filename|
      filename.slice!(0..5)
      @files.push(filename)
    end
    if @name.nil?
      answer = ''
      @files.each do |filename|
        tree_output(filename)
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
    elsif @files.include?(@name + '.tree')
      filename = @name + '.tree'
      tree_output(filename)
    else
      puts 'Данное дерево не растет в данном лесу.'
    end
  end
end

console = Console.new(ENV['NAME'])
console.input_output
