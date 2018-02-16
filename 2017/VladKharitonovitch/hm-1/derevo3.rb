#!/usr/bin/env ruby
require 'json'
require_relative 'parsing.rb'
array_of_trees = []
Dir.foreach('trees') { |x| array_of_trees << x }
entry = array_of_trees.sort!
entry.delete('.')
entry.delete('..')
puts "Добро пожаловать в лес,деревья сортированы по алфавиту!"
entry.each do |file_name|
  file = File.new("trees/#{file_name}")
  puts "Это дерево #{file_name}"
  content = file.read
  array = JSON.parse(content)
  parsing(array)
  after_update_content = @after_parsing_arr
  after_update_content.each_with_index do |lvl, index|
    print "lvl #{index + 1} дерева : "
    @summ_of_nodes = 0
    @lvl_of_tree = 0
    @lvl_of_tree += index
    lvl.each do |node|
      print"#{node} "
      @summ_of_nodes += node
    end
    puts
  end
  if @lvl_of_tree > 5 && @summ_of_nodes > 5000
    puts "дерево уже старое и необходимо его срубить"
  elsif @summ_of_nodes > 5000
    puts "дерево уже старое и необходимо его срубить"
  elsif @lvl_of_tree > 5
    puts "Дерево слишком высокое и необходимо его обрезать"
  else
    puts "Оставить всё как есть"
  end
  puts 'Желаете продолжить? [y/n]'
  answer = gets.chomp
  if answer == 'n'
    puts "Cпасибо,что были в нашем лесу"
    break
  end
end
