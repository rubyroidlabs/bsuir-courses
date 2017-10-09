require_relative 'libs/forest'
require_relative 'libs/lumberjack'

forest = Forest.new('./trees')
if ENV['NAME'].nil?
  forest.each do |i, tree|
    puts tree.name
    puts
    tree.print
    puts Lumberjack.think(tree)
    unless i == forest.length - 2
      print "\nDo you want to see the next one? [y/n]: "
      break if gets.chomp == 'n'
    end
  end
else
  tree = forest.search(ENV['NAME'])
  if tree.nil?
    puts "We don't have such trees in our forest.\n"
  else
    puts tree.name
    puts
    tree.print
    puts Lumberjack.think(tree)
    puts
  end
end
