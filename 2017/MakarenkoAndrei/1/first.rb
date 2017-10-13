#! /usr/bin/env ruby	
#$index = 1
$hight = 1
$b = 1
$bool = true
class Tree
  attr_accessor :value,:left,:right
  def initialize(value,left = nil,right = nil)
    @value = value
    @left = left
    @right = right
  end
  def self.make_tree(array)  
    tree = Tree.new(array[0])    
    tree.left = array[1][0].is_a?(Numeric) ? Tree.new(array[1][0]) : make_tree(array[1][0])
    tree.right = array[1][1].is_a?(Numeric) ? Tree.new(array[1][1]) : make_tree(array[1][1])
    tree 
  end
end


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
    while i<$a[$hight-1].size
        l += $a[$hight-1][i].to_s.length;
        i +=1
    end
    l = l + $a[$hight-1].size 
    i = 0
    while i<$hight
      j = 0    
      string = ''    
      while j<$a[i].size  
        s = space((l - $a[i][j].to_s.size))  
        s2 = space(l)  
        string = string + s2 + $a[i][j].to_s + s2
        j += 1
      end
      puts string    
      l = l / 2
      s = space(l)
      i += 1
    end   
end

def space (length)
 i = 1
 s = ' '    
    while i<length
      s+=' '
      i+= 1
    end
 s    
end
require "json"
file ="trees/" + ENV['NAME']+'.tree'
if ENV['NAME']=nil
  puts 'Пустых деревьев не растет'      
elsif File.file?file  
  forest = Tree.make_tree(JSON.parse(File.read(file))) 
    do_hight(forest)
    $hight = $b
    $a = Array.new($hight){ |index| [] }
    $as = Array.new($hight){ |index| '' }
    $b = 0
    do_array(forest)
    output ($a)
else
  puts 'Такого дерева не растет'  
end                                                                                                                                                                                                                                                                                                                                                                             
