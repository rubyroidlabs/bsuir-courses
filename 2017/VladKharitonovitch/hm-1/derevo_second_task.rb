#!/usr/bin/env ruby
require 'json'
require_relative ("parsing.rb")
#просмотр файлов в каталоге trees
  a=Dir.entries('trees')
#puts a
#делаем новый хэш имён из файлов в каталоге trees
  array_of_trees=Array.new
  Dir.foreach("trees") {|x| array_of_trees<<x }
#puts array_of_trees
#сортировка массива
a=array_of_trees.sort!
a.delete(".")
a.delete("..")
puts "Добро пожаловать в лес,деревья сортированы по алфовиту!"
a.each do |file_name|
  f=File.new ("trees/#{file_name}")
  puts "Это дерево #{file_name}"
  content=f.read
  array=JSON.parse(content)
  parsing(array)
  after_update_content=@after_parsing_arr
    @i=1
    after_update_content.each do |lvl|
      print "lvl #{@i} дерева : "
      @i+=1
      lvl.each{|node| print"#{node} "}
      puts  
    end
    puts "Желаете продолжить? [y/n]"
    otvet=gets.chomp
    break if otvet == "n"
end