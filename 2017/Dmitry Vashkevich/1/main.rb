#!/usr/bin/env ruby
require_relative 'tree.rb'
require_relative 'node.rb'

nameENV = ENV['NAME']
def showTree(name)
  puts name.split('/')[1]
  tree = Tree.new
  tree.getLevel([Node.new(eval File.read(name))])
  tree.show
end

unless nameENV.nil?
  if Dir["trees/#{nameENV}.tree"].empty?
    puts 'Данное дерево не растет в нашем лесу'
  else
    Dir["trees/#{nameENV}.tree"].each do |name|
      showTree(name)
    end
  end
else
  Dir['trees/*.tree'].sort.each do |name|
    showTree(name)
    str = ''
    until str == 'n'|| str =='y'
      puts 'Желаете продолжить? [y,n]'
      str =  gets.chomp
      end
      break if str=='n'
    end
  puts 'Спасибо, что были в нашем лесу'
end


