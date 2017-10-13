#!/usr/bin/env ruby
require 'json'
require_relative ("parsing.rb")
entry=ENV["NAME"].to_s.downcase
  if entry.empty?
    puts "Безымянных деревьев у нас не растет."
  else
    a=Dir.entries('trees')
    hash_of_trees=Hash.new ("")
    Dir.foreach("trees") {|tree_recording| hash_of_trees[tree_recording]="name" }
    key_check=hash_of_trees.has_key?("#{entry}.tree")
    if key_check
      file=File.new ("trees/#{entry}.tree")
      content=file.read
      array=JSON.parse(content)
      parsing(array)
      after_update_content=@after_parsing_arr
        @counter=1
        after_update_content.each do |lvl|
          print "lvl #{@counter} дерева : "
          @counter+=1
          lvl.each{|node| print"#{node} "}
          puts  
        end             
    else
      puts "нету такого дерева"
    end
  end