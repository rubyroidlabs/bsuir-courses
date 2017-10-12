require_relative 'tree.rb'
require_relative 'tree_node.rb'
require_relative 'menu.rb'
require_relative 'file_stream.rb'

main_menu = Menu.new
tree = Tree.new
file_stream = FileStream.new

main_menu.menu(file_stream, tree, ENV["NAME"])
