load 'tree.rb'
require 'json.rb'
# main
begin
  file = File.read('trees/' + ENV['NAME'] + '.tree')
  file = JSON.parse(file)
  tree = Tree.new
  tree.create(file)
  tree.print
rescue TypeError
  if ENV['NAME'].nil?
    puts 'Безымянных деревьев у нас не растет'
  else
    puts 'Данное дерево не растет в данном лесу'
  end
end
