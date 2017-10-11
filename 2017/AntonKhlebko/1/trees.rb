require 'rubygems'
require 'json'
require 'zip/zip'

def is_numeric?(obj)
   obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
end

def spaces(maxlvl, curlvl)
  a = 2 ** (maxlvl - curlvl + 1) - 2
  return ' ' * a
end

class Binary_Tree
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
      return Binary_Tree.new
    end
    self.data = arr[0]
    self.level = lvl
    children = arr[1]
    if is_numeric?(children[0]) == false
      @left = Binary_Tree.new(nil, self.level + 1).create_tree(children[0], self.level + 1)
    elsif
      if children[0].class == nil.class
        @left = Binary_Tree.new
      end
    else
      @left = Binary_Tree.new(children[0], self.level + 1)
    end
    if is_numeric?(children[1]) == false
      @right = Binary_Tree.new(nil, self.level + 1).create_tree(children[1], self.level + 1)
    elsif
      if children[1].class == nil.class
        @right = Binary_Tree.new
      end
    else
      @right = Binary_Tree.new(children[1], self.level + 1)
    end
    return self
  end
  def cut_thehigh
    if @level < 5
      self.left.cut_thehigh
      self.right.cut_thehigh
    else
      self.left = nil
      self.right = nil
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
      if !left.nil?
        left.fake_it(depth)
      end
      if left.nil?
        left = Binary_Tree.new(nil, level + 1)
        left.fake_it(depth)
      end
      if !right.nil?
        right.fake_it(depth)
      end
      if right.nil?
        right = Binary_Tree.new(nil, level + 1)
        right.fake_it(depth)
      end
    end
  end

  def print_lvl(maxlevel, lvl, str)
    if lvl == 1
      str[1] += spaces(maxlevel, lvl)
      (str[1])[(2**(maxlevel - lvl + 1) - 2)/2] = '/'
      str[0] += spaces(maxlevel, lvl)
      if !data.nil?
        buf = "%2s" % "#{data}"
        str[0] += buf
      elsif left.data.nil?
        str[0] += '  '
        str[1] += '  '
      end
      buf = spaces(maxlevel, lvl)
      buf[(2**(maxlevel - lvl + 1) - 2)/2] = '\\'
      str[1] += buf
      str[0] += spaces(maxlevel, lvl)
      return str
    end
    if level < lvl - 1
      str = left.print_lvl(maxlevel, lvl, str)
      str[0] += '  '
      str[1] += '  '
      str = right.print_lvl(maxlevel, lvl, str)
    elsif level == lvl - 1
      buf = spaces(maxlevel, lvl)
      buf[(2**(maxlevel - lvl + 1) - 2)/2] = '/'
      str[1] += buf
      str[0] += spaces(maxlevel, lvl)
      if !left.data.nil?
        buf = "%2s" % "#{left.data}"
        str[0] += buf
        str[0] += spaces(maxlevel, lvl)
        buf = spaces(maxlevel, lvl)
        buf[(2**(maxlevel - lvl + 1) - 2)/2] = '\\'
        str[1] += '  '
        str[1] += buf
      elsif left.data.nil?
        str[0] += '  '
        str[1] += '  '
        buf = spaces(maxlevel, lvl)
        buf[(2**(maxlevel - lvl +  1) - 2)/2] = '\\'
        str[1] += buf
        str[0] += spaces(maxlevel, lvl)
      end
      str[0] += '  '
      str[1] += '  '
      buf = spaces(maxlevel, lvl)
      buf[(2**(maxlevel - lvl + 1) - 2)/2] = '/'
      str[1] += buf
      str[0] += spaces(maxlevel, lvl)
      if !right.data.nil?
        buf = "%2s" % "#{right.data}"
        str[0] += buf
        buf = spaces(maxlevel, lvl)
        buf[(2**(maxlevel - lvl + 1) - 2)/2] = '\\'
        str[1] += '  '
        str[1] += buf
        str[0] += spaces(maxlevel, lvl)
      elsif right.data.nil?
        str[0] += '  '
        buf = spaces(maxlevel, lvl)
        buf[(2**(maxlevel - lvl + 1) - 2)/2] = '\\'
        str[1] += buf
        str[0] += spaces(maxlevel, lvl)
      end
      str
    end
  end

  def print_tree(depth)
    if depth > 6
      depth = 6
    end
    (1..depth).each do |lvl|
      str = Array.new(2)
      str[0] = ""
      str[1] = ""
      str = print_lvl(depth, lvl, str)
      puts str[0]
      puts str[1] if lvl != depth
    end
  end

  def sum_elements(sum = 0)
    sum += data
    if !left.nil?
      if !left.data.nil?
        sum += left.sum_elements
      end
    end
    if !right.nil?
      if !right.data.nil?
        sum += right.sum_elements
      end
    end
    return sum
  end
end

def tree_finder(entry)
  a = JSON (entry.get_input_stream.read)
  tree = Binary_Tree.new(a[0], 1)
  tree.create_tree(a, 1)
  tree.max = 0
  tree.max_depth(tree)
  tree.fake_it(tree.max)
  tree
end

if ENV['NAME'].nil?
  Zip::File.open('trees.zip') do |zip_file|
    zip_file.each do |entry|
        if entry.directory?
          puts "Добро пожаловать в наш лес!"
        else
          puts entry.name
          tree = tree_finder(entry)
          tree.print_tree(tree.max)
          checker = 0
          conclusion = ""
          sum = tree.sum_elements
          if sum > 5000
            checker += 1
            puts "\nОбрезать это дерево!"
          end
          if tree.max > 5 && checker.zero?
            puts "\nЭто дерево слишком высокое, срубить его! " \
            "Его высота #{tree.max}"
            checker += 1
          end
          if checker.zero?
            puts "\nЭто дерево и не слишком высокое и не слишком разрослось, "\
            ' оставьте его в покое.'
          end
          puts "\nХотите продолжить? [y/n]: "
          e = gets.to_s
          e[0] = e[0].downcase
          if e[0] == 'n'
            p 'Спасибо, что были в нашем лесу!'
            break
          end
        end
    end
  end
else
  name = 'trees/' + ENV['NAME'] + '.tree'; checker = 0
  Zip::File.open('trees.zip') do |zip_file|
    zip_file.each do |entry|
      if entry.name != name
        next
      else
        checker = 1
        puts entry.name
        a = JSON (entry.get_input_stream.read)
        tree = Binary_Tree.new(a[0], 1)
        tree.create_tree(a, 1); tree.max = 0
        tree.max_depth(tree)
        tree.fake_it(tree.max)
        tree.print_tree(tree.max)
        if checker == 1
          puts 'Спасибо, что посмотрели на наше дерево!'
          break
        end
      end
    end
    if checker == 0
      puts 'Такого дерева в лесу нет :СССССССССССССС'
    end
  end
end
