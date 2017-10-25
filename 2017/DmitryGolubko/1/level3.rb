file_name = ENV['NAME']

class TreeNode
  attr_accessor :value
  attr_accessor :left_node
  attr_accessor :right_node

  def initialize
    @left_node  = nil
    @right_node = nil
  end
end

class TreeParser
  def self.parse(str)
    tree_root = TreeNode.new
    str.gsub!(/\s/, '')
    str             = str.slice(1, str.size - 2)
    val,            = str.split(/,/)
    children_part   = str.slice(val.size + 1, str.size - val.size)
    tree_root.value = val
    handle_children(children_part, tree_root)
    tree_root
  end

  def self.handle_children(str, parent)
    children          = get_first_children(str)
    parent.left_node  = handle_node(children[0])
    parent.right_node = handle_node(children[1])
  end

  def self.get_first_children(str)
    if str =~ /\A\[\d+[,]\d+\]/
      str = str.slice(1, str.size - 2)
      str = str.split(',')
      return str
    end
    res     = ''
    counter = nil
    str     = str.slice(1, str.size - 1)
    while counter != 0
      res += str[0]
      if str[0] == '['
        if counter.nil?
          counter = 0
        end
        counter += 1
      elsif str[0] == ']'
        if counter.nil?
          counter = 0
        end
        counter -= 1
      end

      str = str.slice(1, str.size - 1)
    end
    [res, str.slice(1, str.size - 2)]
  end

  def self.handle_node(str)
    if str.empty?
      return nil
    end
    node = TreeNode.new
    if str =~ /\A\d+/
      node.value = str
      return node
    end
    str           = str.slice(1, str.size - 2)
    val,          = str.split(/,/)
    children_part = str.slice(val.size + 1, str.size - val.size)
    node.value    = val
    handle_children(children_part, node)
    node
  end
end

class TreePrinter
  def self.out(node, offset)
    unless node.nil?
      out(node.right_node, offset + 1)
      offset.times do
        print('   ')
      end
      print node.value + "\n"
      out(node.left_node, offset + 1)
    end
  end
end

class NodeCounter
  def self.sum_count(node, sum)
    unless node.nil?
      sum += node.value.to_i
      sum = sum_count(node.left_node, sum)
      sum = sum_count(node.right_node, sum)
    end
    sum
  end

  def self.depth_count(node, depth)
    unless node.nil?
      depth = depth_count(node.left_node, depth) + 1
    end
    depth
  end
end

def decision(sum, depth)
  if sum > 5000
    puts 'Срубить'
  else
    puts 'Оставить'
    if depth > 5
      puts 'Обрезать'
    end
  end
end

if file_name.nil?
  file_list = []
  Dir.foreach('trees') do |file|
    file_list.push(file)
  end
  file_list.sort!
  file_list = file_list.slice(2, file_list.size - 1)
  file_list.each do |file|
    arr  = File.read('trees/' + file)
    tree = TreeParser.parse(arr)
    p file
    TreePrinter.out(tree, 0)
    sum = NodeCounter.sum_count(tree, 0)
    depth = NodeCounter.depth_count(tree, 0)
    decision(sum, depth)
    p 'Желаете продолжить? [y/n]'
    answer = gets.chomp.downcase
    unless answer == 'y'
      p 'Спасибо что были в нашем лесу'
      break
    end
  end
elsif File.exist?('trees/' + file_name + '.tree')
  arr  = File.read('trees/' + file_name + '.tree')
  tree = TreeParser.parse(arr)
  TreePrinter.out(tree, 0)
  sum = NodeCounter.sum_count(tree, 0)
  depth = NodeCounter.depth_count(tree, 0)
  decision(sum, depth)
else
  puts 'Данное дерево не растет в данном лесу.'
end
