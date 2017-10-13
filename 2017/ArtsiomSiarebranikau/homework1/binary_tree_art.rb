require 'rubygems'
require 'json'
require 'zip'

@cut = 0
@kill = 0

begin
  def numeric?(obj)
    !obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/).nil?
  end

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
      if arr.class == nil.class
        return BinaryTree.new
      end
      @data = arr[0]
      @level = lvl
      children = arr[1]
      if numeric?(children[0]) == false
        @left = BinaryTree.new(nil, level + 1)
        @left = @left.create_tree(children[0], level + 1)
      elsif children[0].class == nil.class
        @left = BinaryTree.new
      else
        @left = BinaryTree.new(children[0], level + 1)
      end
      if numeric?(children[1]) == false
        @right = BinaryTree.new(nil, level + 1)
        @right = @right.create_tree(children[1], level + 1)
      elsif children[1].class == nil.class
        @right = BinaryTree.new
      else
        @right = BinaryTree.new(children[1], level + 1)
      end
      self
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

    def sum_elements(sum = 0)
      sum += data
      sum += left.sum_elements if !left.nil? && !left.data.nil?
      sum += right.sum_elements if !right.nil? && !right.data.nil?
      sum
    end
  end

  def tree_finder(entry)
    a = entry.get_input_stream.read
    a = JSON a
    tree = BinaryTree.new(a[0], 1)
    tree.create_tree(a, 1)
    tree.max = 0
    tree.max_depth(tree)
    tree
  end

  def operations(sum, max)
    if sum > 5000
      @cut += 1
      puts "\nОбрезать это дерево!" \
      'Cумма всех его узлов = ' + sum.to_s
    elsif max > 5 
      @kill += 1
      puts "\nЭто дерево слишком высокое, срубить его! " \
           'Его высота = ' + max.to_s
    else
      puts "\nЭто отличное дерево,сумма его узлов= " + sum.to_s + \
           ' Высота= ' + max.to_s
    end
  end

  def user_int
    Zip::File.open('trees.zip') do |zip_file|
      zip_file.each do |entry|
        if entry.directory?
          puts 'Добро пожаловать в наш лес!'
        else
          puts entry.name
          tree = tree_finder(entry)
          operations(tree.sum_elements, tree.max)
          puts "\nХотите продолжить? [y/n]: "
          e = gets.to_s
          e[0] = e[0].downcase
          if e[0] == 'n'
            p 'Мы обрезали ' + @cut.to_s + '  деревьев'
            p 'Мы срубили ' + @kill.to_s + '  деревьев'
            p 'Спасибо, что были в нашем лесу!'
            break
          end
        end
      end
    end
  end
  user_int
end
