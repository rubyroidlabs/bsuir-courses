require_relative "utils"

include Utils

tree_name = Utils.tree_name
if tree_name
  tree = tree_by_name(tree_name)
  tree.show
else
  trees = Utils.trees
  trees.each do |tree|
    tree.show
    puts tree.sum_of_nodes > 100 || tree.depth > 5 ? "Chop down!" : "Leave." 
    puts "Do you want to continue? [y/n]?"
    user_answer = gets.chomp.downcase
    until user_answer == "y" || user_answer == "n"
      puts "Please enter 'y' or 'n'"
      user_answer = gets.chomp.downcase
    end
    next  if user_answer == "y"
    break if user_answer == "n"
  end
end
