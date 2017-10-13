#!/usr/bin/env ruby 
require"json"
if ENV['NAME']==nil
    puts "Безымянных деревьев нет"
else
filename ='trees/'+ENV['NAME']+'.tree'
if (File.file?(filename))
$hight = 1
$b = 1
$bool = true
fh = open filename
content = fh.read
fh.close
content = JSON.parse(content)
class Node
attr_accessor :value,:left,:right
  def initialize (value,left = nil,right = nil)
    @value=value
    @left=left
    @right=right
  end
end
class Tree
  def make_tree(array)
    node = Node.new(array[0])
    node.left = array[1][0].is_a?(Numeric) ? Node.new(array[1][0]) : make_tree(array[1][0])
    node.right = array[1][1].is_a?(Numeric) ? Node.new(array[1][1]) : make_tree(array[1][1])
    node
   end
end
root = Tree.new.make_tree(content)
def do_array(tree)
  $a[$b].push(tree.value)
  if tree.left != nil
    $b += 1
    do_array(tree.left)
  end
  if tree.right!=nil
    $b += 1
    do_array(tree.right)
  end
  $b -= 1
end

def do_hight(tree)
  if tree.left != nil
    if $bool
      $b += 1
    end
    do_hight(tree.left)
  end
  if tree.right!=nil
    if $bool
      $b += 1
    end
    do_hight(tree.right)
  end
  $bool = false
end

def output(array)
  i = 0
  l = 0
  while i<$a[$hight - 1].size
    l += $a[$hight - 1][i].to_s.length;
    i += 1
  end
  l = l + $a[$hight - 1].size
  i = 0
  while i<$hight
    j = 0
    string = ''
    while j < $a[i].size
      s = space((l - $a[i][j].to_s.size))
      s2 = space(l)
      string = string + s2 + $a[i][j].to_s + s2
      j += 1
    end
    puts string
    l /= 2
    s = space(l)
    i += 1
  end
end

def space(length)
  i = 1
  s = ' '
  while i < length
    s += ' '
    i += 1
  end
  s
end
do_hight(root)
$hight = $b
$a = Array.new($hight) { |index| [] }
$as = Array.new($hight) { |index| '' }
$b = 0
do_array(root)
output($a)
else puts "такого дерева нет"
end
end
