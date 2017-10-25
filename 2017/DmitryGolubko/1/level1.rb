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

if file_name.nil?
  puts 'Безымянных деревьев у нас не растет.'
elsif File.exist?('trees/' + file_name + '.tree')
  arr  = File.read('trees/' + file_name + '.tree')
  tree = TreeParser.parse(arr)
  TreePrinter.out(tree, 0)
else
  puts 'Данное дерево не растет в данном лесу.'
end
