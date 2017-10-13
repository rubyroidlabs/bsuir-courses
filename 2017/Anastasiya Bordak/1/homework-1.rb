require 'pry'
require 'json'
class TREE
	attr_accessor :value, :left, :right
	def initialize value,left = nil,right = nil
		@value = value
		@left = left
		@right = right
	end
end
def creat_tree(tree, root)
	if tree.size == 2 && root!=nil
		
		
		
		hash2 = JSON.parse(tree[1][1].to_s)
		if(hash2[2]  == 1 || hash2[2] == 0)
			root.left = TREE.new(hash2)
		else root.left = TREE.new(hash2[0])
			creat_tree(hash2,root.left)
		end
		hash1 = JSON.parse(tree[1][0].to_s)
		if(hash1[2] == 1 || hash1[2] == 0)
			root.right = TREE.new(hash1)
		else root.right = TREE.new(hash1[0])
			creat_tree(hash1,root.right)
		end
		
	end
	return root
end
def pre_order(node)
	return if node.nil?
	puts node.value
	pre_order(node.left)
	pre_order(node.right)
end
def hight(node)
if(node == nil)
	return 0
else
 left = hight(node.left)
 right = hight(node.right)
if(left>right)
	return left + 1
else return right +1
end
end
end
def sum(node,i)
	if node == nil
	return i
	end
	i += node.value
	i = sum(node.left,i)
	i = sum(node.right,i)
end
if ENV['NAME'] == nil 
puts 'Enter name, please'
elsif File.exist? (ENV['NAME'])
file = File.open(ENV['NAME'])
	
	tree = JSON.load(file)
	root = TREE.new(tree[0])
	file.close
	creat_tree(tree,root)
	puts("Tree #{ENV['NAME']}")
	if sum(root,0) > 5000
	puts "Chop down"
	elsif hight(root) > 5
	puts "Crop"
	else puts "Keep"
	end
	else puts 'No file with such name'
end

binding.pry
