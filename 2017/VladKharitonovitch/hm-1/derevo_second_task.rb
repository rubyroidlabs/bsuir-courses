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
    lvl.each { |node| print"#{node} " }
    puts
  end
  puts 'Желаете продолжить? [y/n]'
  answer = gets.chomp
  break if answer == 'n'
end
