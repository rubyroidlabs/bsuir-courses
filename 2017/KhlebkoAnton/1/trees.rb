#!/usr/bin/env ruby
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
  def initialize(key = nil)
    @max = nil
    @data = key
    @left = nil
    @right = nil
    @level = nil
  end

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
    if self.data != nil && self.level != nil
      if self.level > head.max
        head.max = self.level
        self.left.max_depth(head) if self.left.class != nil.class
        self.right.max_depth(head) if self.right.class != nil.class
      end
    end
  end

  def fake_it(depth)
    if self.level < depth
      if self.left != nil
        self.left.fake_it(depth)
      end
      if self.left == nil
        self.left = Binary_Tree.new(nil, self.level + 1)
        self.left.fake_it(depth)
      end
      if self.right != nil
        self.right.fake_it(depth)
      end
      if self.right == nil
        self.right = Binary_Tree.new(nil, self.level + 1)
        self.right.fake_it(depth)
      end
    end
  end

  def print_lvl(maxlevel, lvl, str)
    if lvl == 1
      str += spaces(maxlevel, lvl)
      if self.data != nil
        buf = "%2s" % "#{self.data}"
        str += buf
      elsif self.left.data == nil
        str += "  "
      end
      str += spaces(maxlevel, lvl)
      return str
    end
    if self.level < lvl - 1
      str = self.left.print_lvl(maxlevel, lvl, str)
      str += "  "
      str = self.right.print_lvl(maxlevel, lvl, str)
    elsif self.level == lvl - 1
      str += spaces(maxlevel, lvl)
      if self.left.data != nil
        buf = "%2s" % "#{self.left.data}"
        str += buf
        str += spaces(maxlevel, lvl)
      elsif self.left.data == nil
        str += '  '
        str += spaces(maxlevel, lvl)
      end
      str += "  "
      str += spaces(maxlevel, lvl)
      if self.right.data != nil
        buf = "%2s" % "#{self.right.data}"
        str += buf
        str += spaces(maxlevel, lvl)
      elsif self.right.data == nil
        str += "  "
        str += spaces(maxlevel, lvl)
      end
      return str
    end

  end

  def print_tree(depth)
    (1..depth).each do |lvl|
      str = ""
      str = self.print_lvl(depth, lvl, str)
      puts str
    end
  end

  def sum_elements(sum = 0)
    sum += self.data
    if self.left != nil
      if self.left.data != nil
        sum += self.left.sum_elements
      end
    end
    if self.right != nil
      if self.right.data != nil
        sum += self.right.sum_elements
      end
    end
    return sum
  end
end

if ENV['NAME'] == nil
  Zip::File.open('trees.zip') do |zip_file|
    zip_file.each do |entry|
        if entry.directory?
          puts "Добро пожаловать в наш лес!"
        else
          puts "#{entry.name}"
          a = entry.get_input_stream.read
          a = eval a
          tree = Binary_Tree.new(a[0], 1)
          tree.create_tree(a, 1)
          tree.max = 0
          tree.max_depth(tree)
          tree.fake_it(tree.max)
          tree.print_tree(tree.max)
          if tree.max > 5
            puts "Cрубить это дерево"
          end
          sum = tree.sum_elements
          if sum > 5000
            puts "Обрезать это дерево!"
          end
          puts "\nХотите ли вы пройти к следующему дереву? [y/n]: "
          e = gets.to_s
          if e[0].downcase == ('n')
            p "Спасибо, что были в нашем лесу!"
            break
          end
        end
    end
  end
else
  name = 'trees/' + ENV['NAME'] + '.tree'
  checker = 0
  Zip::File.open('trees.zip') do |zip_file|
    zip_file.each do |entry|
      if entry.name == name
          checker =1
          puts "#{entry.name}"
          a = entry.get_input_stream.read
          a = eval a
          tree = Binary_Tree.new(a[0], 1)
          tree.create_tree(a, 1)
          tree.max = 0
          tree.max_depth(tree)
          tree.fake_it(tree.max)
          tree.print_tree(tree.max)
          if tree.max > 5
            puts "Cрубить это дерево"
          end
          sum = tree.sum_elements
          if sum > 5000
            puts "Обрезать это дерево!"
          end
          if checker == 1
            p "Спасибо, что посмотрели на наше дерево!"
            break
          end
        end
    end
    if checker == 0
      puts "Такого дерева в лесу нет :СССССССССССССС"
    end
  end
end
