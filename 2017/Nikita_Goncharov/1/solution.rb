require 'json'
require_relative 'tree'
require_relative 'decision'
name = ENV['NAME']
tree = Tree.new
filenames = Dir.glob('*/*.tree')
filenames = filenames.sort
begin
  if !name
    filenames.each do |filename|
      file = File.read("./#{filename}")
      tree_arr = JSON.parse(file)
      tree.rec_arr(tree, tree_arr)
      tree.print_leveled_tree(tree, 0, 2)
      tree.get_tree_sum(tree)
      tree.get_max_depth(tree, 0)
      sum = tree.sum
      depth = tree.depth
      get_decision(sum, depth)
      puts 'Желаете продолжить?[y/n] '
      if gets == "n\n"
        break
      end
    end
  else
    file = File.read("./trees/#{name}.tree")
    tree_arr = JSON.parse(file)
    tree.rec_arr(tree, tree_arr)
    tree.print_leveled_tree(tree, 0, 2)
    tree.get_tree_sum(tree)
    tree.get_max_depth(tree, 0)
    sum = tree.sum
    depth = tree.depth
    get_decision(sum, depth)
  end
rescue StandardError
  puts 'Такие деревья здесь не растут'
end
puts 'Спасибо, что были в нашем лесу'