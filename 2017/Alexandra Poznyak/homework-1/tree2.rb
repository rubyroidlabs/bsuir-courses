require 'json'
require 'pry'

class TreeCreate
  def self.print_tree(tree)
    depth = tree_depth tree
    1.upto(depth) do |i|
      @spaces = depth - i + 1
      print '  ' * (2**@spaces / 2)
      print_level(tree, i)
      next unless i != depth
      print "\n" + '  ' * ((2**(@spaces - 1)) / 2)
      (2**(i - 1)).times do
        print ' /' + '  ' * ((2**(@spaces - 1)) - 1)
        print '\\ ' + '  ' * ((2**(@spaces - 1)) - 1)
      end
    end
  end

  def self.tree_depth(way)
    left = way[1][0].class == Integer ? 1 : tree_depth(way[1][0])
    right = way[1][1].class == Integer ? 1 : tree_depth(way[1][1])
    (left >= right ? left : right) + 1
  end

  def self.print_level(way, level)
    level -= 1
    if level.zero?
      p = way.class == Array ? way[0] : way
      print format('%-2d', p)
      print '  ' * (2**@spaces - 1)
    else
      print_level(way[1][0], level)
      print_level(way[1][1], level)
    end
  end
end

dir = Dir.entries('/home/artser/work/trees').sort
dir.delete('.')
dir.delete('..')
if ENV['NAME'].nil?
  dir.each do |i|
    puts "\n#{i}"
    tree = JSON.parse(File.new('@i.to_s').read)

    TreeCreate.print_tree tree

    print 'Хотите продолжить? [y/n] '

    answer = ''
    loop do
      answer = gets.chomp
      break if %w[y n].include?(answer)
    end
    break if answer == 'n'
  end
  puts "Спасибо что побывали в нашем лесу!\n\r"
elsif dir.include? ENV['NAME']
  tree = JSON.parse(File.new("trees/@ENV['NAME'.to_s").read)
  TreeCreate.print_tree tree
else
  puts "\nВ нашем лесу нет такого дерева.\n\r"
end
