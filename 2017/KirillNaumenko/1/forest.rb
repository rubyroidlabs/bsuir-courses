require_relative './trees'

STOP = 'n'.freeze
KEEP_ON = 'y'.freeze

forest_trees =
  Dir.entries('./trees')
     .reject { |filename| ['.', '..'].include?(filename) }.sort

puts forest_trees.first
puts print_tree forest_trees.first
puts 'Do u want to continue? [y/n]'
def run_forest_run(forest_trees)
  1.upto(forest_trees.length - 1) do |i|
    typed_button = gets.chomp
    if typed_button == KEEP_ON
      puts print_tree forest_trees[i]
      puts 'Do u want to continue? [y/n]'
    elsif typed_button == STOP
      abort 'Thanks for visiting our forest'
    else
      puts 'Please typed correct button! [y] or [n]'
    end
  end
  puts 'Thanks for visiting our forest'
end

run_forest_run(forest_trees)
