require_relative 'utils'

include Utils

tree_name = Utils.tree_name

if tree_name
  begin
    tree = tree_by_name(tree_name)
    tree.show
  rescue
    puts "Tree '#{tree_name}' does not exist!"
  end
else
  puts 'Tree name is not specified!'
end
