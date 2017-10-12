#!/usr/bin/env ruby
require_relative('Tree')
require 'json'

fileName = ENV["NAME"]	
ans = 'y'	
data = ''
fileList = []
Dir.foreach('trees') do |i|
	fileList << i
end
fileList.sort!
2.times { fileList.shift }
unless fileName.nil? 
	if fileName == ''
		puts "Безымянных деревьев у нас не растет."
		exit 
	end
	if fileList.include?(fileName)
		data = File.read("trees/" + fileName)
		elements = JSON.parse(data)
		tree = Tree.new(elements.shift)
		tree.createAndOut(elements)
		#обработка дерева и вывод.
	else 
		puts "Данное дерево не растет в данном лесу."
	end
else 
	while fileList[0] != nil and ans == 'y' do
		ans = 'm'	
		fileName = fileList.shift
		puts fileName
		data = File.read("trees/" + fileName)
		elements = JSON.parse(data)
		tree = Tree.new(elements.shift)
		tree.createAndOut(elements)
		#обработка дерева и вывод.
		print "Желаете продолжить? [y/n] "
		ans = gets.chomp.downcase
		while ans!='y' and ans!='n' do
			print "Неверный выбор, повторите. "
			ans = gets.chomp.downcase
		end
	end
puts "Спасибо, что были в нашем лесу."
end

