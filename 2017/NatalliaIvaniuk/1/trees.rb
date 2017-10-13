require 'json'

name = ENV['NAME']
forest = []
Dir.foreach('trees') do |filename|
  forest << filename if filename =~ /^\w/
end
forest.sort!
if forest.include? name + '.tree'
  f = 'trees/' + name + '.tree'
    tree = File.read(f).delete!("\n")
  tree = JSON.parse(tree)
  # puts tree.class
  print tree
  puts ' '
elsif name.empty?
  puts 'Безымянных деревев у нас не растет.'
  forest.each do |filename|
    puts filename
    f = 'trees/' + filename
    tree = File.read(f).delete!("\n")
    tree = JSON.parse(tree)
    print tree
    puts ' '
    answer = ''
    loop do
      print 'Желаете продолжить? [y/n] '
      answer = gets.chomp
      break if %w(y [and] n).include? answer
      puts 'Желаете продолжить? [y/n] '
    end
    if answer == 'n'
      puts 'Спасибо что были в нашем лесу.'
      break
    end
  end
elsif puts 'Данное дерево не растет в данном лесу.'
end
