require_relative 'lib/tree_processer.rb'

dir = Dir.entries('trees').sort
dir.delete('.')
dir.delete('..')

if ENV['NAME'].nil?
  dir.each do |i|
    puts "\n#{i}"
    tree = JSON.parse(File.new("trees/#{i}").read)

    TreeProcesser.print_tree tree

    if TreeProcesser.tree_age(tree) > 5000
      puts "Дерево слишком старое, его нужно срубить...\n\r"
      puts
    elsif TreeProcesser.tree_depth(tree) > 5
      puts "Дерево слишком высокое, его нужно обрезать.\n\r"
      puts
    else
      puts "Хорошее дерево! Оставим его!\n\r"
      puts
    end

    print 'Хотите продолжить? [y/n] '

    answer = ''
    loop do
      answer = gets.chomp
      break if answer == 'y' || answer == 'n'
    end
    break if answer == 'n'

    puts
  end
  puts "Спасибо что побывали в нашем лесу! (:\n\r"

elsif dir.include? ENV['NAME']

  puts "Какое красивое дерево!\n\r"
  tree = JSON.parse(File.new("trees/#{ENV['NAME']}").read)
  TreeProcesser.print_tree tree

else

  puts "\nУ нас в лесу не растёт такое дерево.\n\r"

end
