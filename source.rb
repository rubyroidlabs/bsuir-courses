#[30,[[1,[[5,[[10,[14,38]],[38,[7,18]]]],[19,[[10,[19,16]],[29,[8,7]]]]]],[35,[[46,[[36,[19,22]],[44,[7,15]]]],[22,[[19,[17,42]],[46,[16,7]]]]]]]]
require 'pry'
require 'json'

file = IO.read("./trees/" + ENV["NAME"] + ".tree")
#folder =IO.read("./trees") 
puts file

tree = JSON.parse(file.gsub(/(\d+)/,'\1'))

def draw tree

	tree.each do |item|
		if item.class == 1.class
			print "#{item} "
		else
			draw item
		end

	end
end

def choice tree
	if tree.flatten.sum  > 5000
		puts "Дерево слишком старое. Нужно срубить."
	elsif Math.log2(tree.flatten.count + 1) > 5
		puts "Дерево слишком высокое. Нужно укоротить."
	else
		puts"Оставить все как есть."
	end
end
choice tree
#draw tree
#puts "#{tree.flatten}"
