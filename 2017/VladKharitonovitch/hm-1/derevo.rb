#!/usr/bin/env ruby
require 'json'
require_relative ("parsing.rb")
  vhod=ENV["NAME"].to_s.downcase
  if vhod.empty?
    puts "Безымянных деревьев у нас не растет."
  else
#просмотр файлов в каталоге trees
  a=Dir.entries('trees')
#puts a
#делаем новый хэш имён из файлов в каталоге trees
  hash_of_trees=Hash.new ("")
  Dir.foreach("trees") {|x| hash_of_trees[x]="name" }
#puts hash_of_trees
#проверяет хэш на наличие искомого значения,если есть,то возвращает true
  b=hash_of_trees.has_key?("#{vhod}.tree")
    if b
      f=File.new ("trees/#{vhod}.tree")
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
               
    else
      puts "нету такого дерева"
    end
end
