require 'json'
require 'pry'

name = ENV['NAME'] + '.tree'
forest = []
Dir.foreach('trees') do |filename|
  forest << filename if filename =~ /^\w/
end

forest.sort!

if forest.include? name
  f = 'trees/' + name
  tree_str = File.read(f).delete!("\n")
  tree = JSON.parse(tree_str)
  print tree
elsif name.empty?
  puts 'Безымянных деревев у нас не растет.'
else
  puts 'Данное дерево не растет в данном лесу.'

  answer = ''
  forest.each do |filename|
    puts filename
    f = 'trees/' + filename
    tree_str = File.read(f).delete!("\n")
    tree = JSON.parse(tree_str)
    # print tree
    loop do
      print tree
      print 'Желаете продолжить? [y/n] '
      answer = gets.chomp
      break if %w[y n].include? answer
      puts 'Желаете продолжить? [y/n] '
    end
    if answer == 'n'
      puts 'Спасибо что были в нашем лесу.'
      break
    end
  end
end
