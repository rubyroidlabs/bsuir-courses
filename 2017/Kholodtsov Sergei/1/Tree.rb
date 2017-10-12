#!/usr/bin/env ruby

class Tree
	attr_reader :root, :sum, :depth, :flag
	
	def initialize(item)
		@root = Node.new(item)
		@sum = item
		@depth = 1
	end

	def createAndOut(item)
		addNode(item,@root)
		outTree(@root, @depth)
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
	
	def getElemLevel (level,root,elems)
			if root.class == Node
				if level.zero? 
					elems << root.data
					elems
				end
			  elems = getElemLevel(level - 1, root.left, elems)
				elems = getElemLevel(level - 1, root.right, elems)
			else if level.zero? 	 
				elems << root
				end
			end
		elems
	end

	def outTree(root, depth)
		counter = (2 ** (depth + 1) - 2) / 2
		depth.times do |i|
			list = []
			list = getElemLevel(i,root,list)
			counter = counter - 1
			firstTab = counter
			counter = counter / 2
			secondTab = counter
			if secondTab != 0 
				firstLine = ' ' * (secondTab+1)
			else 
				firstLine = ' ' * firstTab
			end
			secondLine = ' ' * secondTab
			list.each do |j|
				j = j.to_s
				if j.size == 1 
					j += ' '
				end
				if secondTab != 0 and secondTab + 1 != firstTab
					firstLine += '_' * (firstTab-secondTab-1) + j + '_' * (firstTab-secondTab-1) + ' ' * (2*secondTab+4)
				else 
					firstLine += j + '  ' * (firstTab+1)
				end
				secondLine += '/' + ' ' * firstTab + '\\' + ' ' * (firstTab+2)
			end
			puts firstLine
			puts secondLine if i != depth - 1
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
