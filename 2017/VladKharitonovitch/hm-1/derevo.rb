#!/usr/bin/env ruby
require 'json'
require_relative 'parsing.rb'
entry = ENV['NAME'].to_s.downcase
if entry.empty?
  puts 'Безымянных деревьев у нас не растет.'
else
  hash_of_trees = Hash.new ''
  Dir.foreach('trees') do |tree_recording|
    hash_of_trees[tree_recording] = 'name'
  end
  key_check = hash_of_trees.key?("#{entry}.tree")
  if key_check
    file = File.new("trees/#{entry}.tree")
    content = file.read
    array = JSON.parse(content)
    parsing(array)
    after_update_content = @after_parsing_arr
    after_update_content.each_with_index do |lvl, index|
      print "lvl #{index + 1} дерева : "
      lvl.each { |node| print"#{node} " }
      puts
    end
  else
    puts 'нету такого дерева'
  end
end
