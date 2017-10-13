require_relative './trees'

MAX_LVL_DEPTH = 5
MAX_NODE_SUM = 5000

STOP = 'n'.freeze
KEEP_ON = 'y'.freeze

forest_trees =
  Dir.entries('./trees')
     .delete_if { |filename| filename == '.' || filename == '..' }.sort
hop = 1
puts forest_trees.first
printer(forest_trees[0])
puts 'Do u want to continue? [y/n]'
while hop != (forest_trees.count - 1)
  typed_button = gets.chomp
  if typed_button == KEEP_ON
    puts forest_trees[hop]
    printer(forest_trees[hop += 1])
    puts 'Do u want to continue? [y/n]'
  elsif typed_button == STOP
    abort 'Thanks for visiting our forest'
  end
end
puts 'Thanks for visiting our forest'
