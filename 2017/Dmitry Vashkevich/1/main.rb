require_relative 'tree.rb'
require_relative 'node.rb'

name_env = ENV['NAME']
def show_tree(name)
  puts name.split('/')[1]
  tree = Tree.new
  tree.get_level([Node.new(Array.instance_eval(File.read(name)))])
  tree.show
end

if name_env.nil?
  Dir['trees/*.tree'].sort.each do |name|
    show_tree(name)
    str = ''
    until str == 'n' || str == 'y'
      puts 'Желаете продолжить? [y,n]'
      str = gets.chomp
    end
    break if str == 'n'
  end
  puts 'Спасибо, что были в нашем лесу'
elsif Dir["trees/#{name_env}.tree"].empty?
  puts 'Данное дерево не растет в нашем лесу'
else
  Dir["trees/#{name_env}.tree"].each do |name|
    show_tree(name)
  end
end
