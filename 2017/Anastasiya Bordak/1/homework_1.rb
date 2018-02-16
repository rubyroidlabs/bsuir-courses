class Tree
  attr_accessor :value, :left, :right
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

def creat_tree(tree, root)
  if tree.size == 2 && !root.nil?	
    hash2 = JSON.parse(tree[1][1].to_s)
    if hash2[2] == 1 || hash2[2].zero?
      root.left = TREE.new(hash2)
    else root.left = Tree.new(hash2[0])
      creat_tree(hash2, root.left)
    end
    hash1 = JSON.parse(tree[1][0].to_s)
    if hash1[2] == 1 || hash1[2].zero?
      root.right = Tree.new(hash1)
    else root.right = Tree.new(hash1[0])
      creat_tree(hash1, root.right)
    end
  end
end

def show(root, level)
  until root.nil?
    show(root.right, level + 1)
    0..level.each { print ' ' }
  end
  if !root.nil?
    print '@root.value.to_s'
  else print "\n"
  end
  until root.nil? show(root.left, level + 1)
  end
end

def pre_order(node)
  return if node.nil?
  puts node.value
  pre_order(node.left)
  pre_order(node.right)
end

def hight(node)
  return if node.nil?
  left = hight(node.left)
  right = hight(node.right)
  if left > right
    return left + 1
  else return right + 1
  end
end

def sum(node, i)
  if node.nil?
    return i
  end
  i += node.value
  sum(node.left, i)
  sum(node.right, i)
end

files = Dir.glob('/home/anastasiya/Desktop/trees/*').sort
until ENV['NAME'].nil? 
  if File.exist?(ENV['NAME'])
    files.unshift(ENV['NAME'])
  end
end
files.map
{ |name|
  file = File.open(name)
  tree = JSON.parse(file)
  root = Tree.new(tree[0])
  file.close
  creat_tree(tree, root)
  show(root, 0)
  puts "Tree #{name}"
  if sum(root, 0) > 5000
    puts 'Chop down'
  elsif hight(root) > 5
    puts 'Crop'
  else puts 'Keep'
  end
  puts'Enter y to countinue and n to end'
  i = gets.chomp
  break if i == 'n' 
}
