#!/usr/bin/env ruby
 
all_trees = Dir["*/**/*.tree"].each { |f| File.open(f) if File.file?(f) }
last_tree = all_trees.length

def look_tree (name_search)

	content = File.open(name_search , 'r') {|file| file.read}
		
	unit_tree = content.scan(/\d{1,5}/)
	unit_tree.collect!{|item| item.to_i}
	age_tree = unit_tree.inject(0){ |result, elem| result = result + elem }
	
	mas_branch = content.split','
	height_tree = mas_branch[-1].scan("]").size / 2 + 1 

	print content

	if age_tree >= 5000 and height_tree > 5
		print "\n Дерево большое и старое - его надо срубить.\n"
	elsif age_tree >= 5000 and height_tree < 5
		print "\n Дерево старое - его надо срубить.\n"
	elsif age_tree < 5000 and height_tree > 5
		print "\n Дерево большое - его надо подрезать.\n"
	else
		print "\nС деревом все впорядке! Его не надо трогать!\n"
	end

end

print "Вы ищете  какое-то конкретное дерево[1] или показать все[2]?\n"

answer_search = nil

while answer_search == nil

	answer_search = gets.to_i

	if answer_search == 1
		
		print "Как зовут дерево, что вы ищете?\n"
		name_search = gets.chomp
		name_search = "trees/" + name_search + ".tree" 

		if all_trees.include?( name_search ) == true
			
			print "такое дерево есть, вот оно ...\n"
			look_tree(name_search)
			
		else
			print "нет такого дерева\n"
		end

		elsif answer_search == 2
			
			repeat = "y"
			len = 0
						
			while repeat == "y"  

				name_search = all_trees.sort[len]
				
				if name_search == all_trees.sort[-1]
					print "\n Это последнее дерево с именем " + name_search + "\n"
					look_tree(name_search)
					repeat = "by"
					print "\nСпасибо за прогулку!\n"
				else
					print "\nПеред Вами дерево с именем "+ name_search + "\n"
					look_tree(name_search)
					len += 1
					print "\nЖелаете продолжить? [y/n]"
					repeat = gets.chomp
				end
			end
				
			else
				print "Ваш выбор мне не понятен, попробуйте ещё раз ...\n"
				answer_search = nil
	end
end