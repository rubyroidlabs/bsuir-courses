#!/usr/bin/env ruby

class Tree
  attr_reader :root, :sum, :depth, :flag

  def initialize(item)
    @root = Node.new(item)
    @sum = item
    @depth = 1
  end

  def createAndOut(item)
    addNode(item, @root)
    out_Tree(@root, @depth)
  end

  def addNode(item, node)
    left = item[0][0]
    right = item[0][1]
    if left.class == Array
      i = left.shift
      node.left = Node.new(i)
      @flag != 1 ? @depth = @depth + 1 : @depth
      @sum = @sum + i
      addNode(left, node.left)
    else
      node.left = left
      @sum = @sum + left
      @flag != 1 ? @depth = @depth + 1 : @depth
      @flag = 1
    end
    if right.class == Array
      i = right.shift
      node.right = Node.new(i)
      @sum = @sum + i
      addNode(right, node.right)
    else
      node.right = right
      @sum = @sum + right
    end
  end

  def getElemLevel (level, root, elems)
    if root.class == Node
      if level.zero?
        elems << root.data
        elems
      end
      elems = getElemLevel(level - 1, root.left, elems)
      elems = getElemLevel(level - 1, root.right, elems)
    elsif level.zero?
      elems << root
    end
    elems
  end

  def out_Tree(root, depth)
    counter = (2 **(depth + 1) - 2) / 2
    depth.times do |i|
      list = []
      list = getElemLevel(i, root, list)
      counter -= counter
      first_Tab = counter
      counter /= 2
      second_Tab = counter
      if second_Tab != 0
        first_Line = ' ' * (second_Tab + 1)
      else
        first_Line = ' ' * first_Tab
      end
      second_Line = ' ' * second_Tab
      list.each do |j|
        j = j.to_s
        if j.size == 1
          j += ' '
        end
        if second_Tab != 0 && second_Tab + 1 != first_Tab
        	l = first_Tab - second_Tab - 1
          first_Line += '_' * l + j + '_' * l + ' ' * (2 * second_Tab + 4)
        else
          first_Line += j + '  ' * (first_Tab + 1)
        end
        second_Line += '/' + ' ' * first_Tab + '\\' + ' ' * (first_Tab + 2)
      end
      puts first_Line
      puts second_Line if i != depth - 1
    end
    if @sum > 5000
      puts 'Срубить.'
    elsif @depth > 5
      puts 'Обрезать.'
    else
      puts 'Оставить.'
    end
  end
end

class Node < Tree
  attr_accessor :left, :right, :data

  def initialize(item)
    @data = item
  end
end
