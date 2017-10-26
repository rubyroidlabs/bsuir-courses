require_relative('tree')
require 'json'

file_name = ENV['NAME']
ans = 'y'
file_list = []
Dir.foreach('trees') do |i|
  file_list << i
end
file_list.sort!
2.times { file_list.shift }
if file_name.nil?
  while file_list[0].nil? == false
    ans != 'y' ? break : ans = 'm'
    file_name = file_list.shift
    puts file_name
    data = File.read('trees/' + file_name)
    elements = JSON.parse(data)
    tree = Tree.new(elements.shift)
    tree.create_and_out(elements)
    print 'Желаете продолжить? [y/n] '
    ans = gets.chomp.downcase
  end
else
  if file_name == ''
    puts 'Безымянных деревьев у нас не растет.'
    exit
  end
  if file_list.include?(file_name)
    data = File.read('trees/' + file_name)
    elements = JSON.parse(data)
    tree = Tree.new(elements.shift)
    tree.create_and_out(elements)
  else
    puts 'Данное дерево не растет в данном лесу.'
    exit
  end
end
puts 'Спасибо, что были в нашем лесу.'
