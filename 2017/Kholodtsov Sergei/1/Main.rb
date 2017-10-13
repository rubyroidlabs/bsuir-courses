#!/usr/bin/env ruby
require_relative('Tree')
require 'json'

file_name = ENV["NAME"]
ans = 'y'	
data = ''
file_list = []
Dir.foreach('trees') do |i|
	file_list << i
end
file_list.sort!
2.times { file_list.shift }
unless file_name.nil?
	if file_name == ''
		puts "Безымянных деревьев у нас не растет."
		exit 
	end
	if file_list.include?(file_name)
		data = File.read("trees/" + file_name)
		elements = JSON.parse(data)
		tree = Tree.new(elements.shift)
		tree.create_and_out(elements)
	else 
		puts "Данное дерево не растет в данном лесу."
	end
else 
	while file_list[0] != nil and ans == 'y' do
		ans = 'm'	
		file_name = file_list.shift
		puts file_name
		data = File.read("trees/" + file_name)
		elements = JSON.parse(data)
		tree = Tree.new(elements.shift)
		tree.create_and_out(elements)
		print "Желаете продолжить? [y/n] "
		ans = gets.chomp.downcase
		while ans!='y' and ans!='n' do
			print "Неверный выбор, повторите. "
			ans = gets.chomp.downcase
		end
	end
puts "Спасибо, что были в нашем лесу."
end

