require './lib/utils.rb'

name = ENV['NAME']
if name.nil?
  Utils.show_all_trees
  puts "\nСпасибо что были в нашем лесу"
  exit
end
tree = Utils.read_tree_by_name(name)
tree.show_tree
tree.check
