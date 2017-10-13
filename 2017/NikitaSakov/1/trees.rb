require 'json'

module Tree
  def self.draw(name_of_file)
    deep = 0
    summ = 0
    spaces = 140
    queue = Array.new
    queue_temp = Array.new
    level_nodes = Array.new
    tree_string = File.read(name_of_file)
    tree_inf = JSON.parse(tree_string)
    queue << tree_inf
    while !queue.empty?
      queue.length.times do |i|
        2.times do |j|
          if queue[i][j].is_a? Integer
            level_nodes << queue[i][j]
            summ += queue[i][j]
          else
            queue_temp << queue[i][j]
          end
        end
      end
      if level_nodes.length != 0
        deep += 1
        spaces = level_with_slashes(level_nodes, spaces, deep)
      end
      queue = Array.new
      queue += queue_temp
      queue_temp = Array.new
      level_nodes = Array.new
    end
    if deep > 4
      puts 'Остальная часть дерева скрылась за облаками'
    end
    what_to_do(summ, deep)
  end

  def self.write_spaces(spaces)
    spaces.times do
      print ' '
    end
  end

  def self.level_with_slashes(level_nodes, spaces, deep)
    if deep < 5
      spaces /= 2
      if deep > 1
        write_slash(level_nodes, spaces)
      end
      puts
      write_level(level_nodes, spaces)
      puts
    end
    spaces
  end

  def self.write_level(level_nodes, spaces)
    level_nodes.length.times do |i|
      if i.zero?
        write_spaces(spaces)
      else
        write_spaces(2 * spaces)
      end
      print level_nodes[i]
    end
  end

  def self.write_slash(level_nodes, spaces)
    level_nodes.length.times do |i|
      if i.zero?
        write_spaces(spaces)
      else
        write_spaces(2 * spaces)
      end
      if (i % 2).zero?
        print ' /'
      else
        print '\ '
      end
    end
  end

  def self.what_to_do(summ, deep)
    if summ > 5000
      puts 'Это дерево слишком тяжелое. Нужно его срубить'
    end
    if deep > 5 && summ < 5001
      puts 'Это дерево слишком высокое. Нужно его обрезать'
    end
    if deep < 6 && summ < 5001
      puts 'Дерево еще нормальное. Можно его оставить'
    end
  end
end

names = Dir.entries('/home/nikita/Документы/trees')
names.sort!
if ENV['NAME'].nil?
  2.upto(names.length) do |i|
    Tree.draw(names[i])
    puts 'Хотите посмотреть еще одно дерево?<д/н>'
    choise = gets.chomp
    if choise != 'д'
      puts 'Всего хорошего!'
      break
    end
  end
else
  name_of_file = ENV['NAME'] + '.tree'
  names.length.times do |i|
    if names[i] == name_of_file
      Tree.draw(name_of_file)
      puts 'Всего хорошего!'
    end
  end
end
