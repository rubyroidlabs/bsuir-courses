require_relative 'libs/tree'
require 'json'

if ENV['NAME'].nil?
  file_arr = []
  Dir.foreach('trees') do |i|
    file_arr << i
  end

  until file_arr[0].nil?
    file = File.read('trees/' + file_arr.shift)
    array = JSON.parse(file)
    node = Node.new(array.shift)
    node.insert(node, array.shift) until array.nil?
    # node.print
    node.check(node)
    puts 'Желаете продолжить? [y/n]'
    break if gets.chomp == 'n'
  end
elsif File.exist?('trees/' + ENV['NAME'] + '.tree')
  file = File.read('trees/' + ENV['NAME'] + '.tree')
  array = JSON.parse(file)
  node = Node.new(array.shift)
  node.insert(node, array.shift) until array.nil?
  # node.print
  node.check(node)
else
  puts 'Дерева с таким именем нет'
end
