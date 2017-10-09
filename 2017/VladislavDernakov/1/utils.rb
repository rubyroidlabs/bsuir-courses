require "json"

require_relative "models/tree_grower"

PATH_TO_TREES = "./trees/"
TREE_EXT   = ".tree"

module Utils 
	def tree_name
		ENV["NAME"]
	end
	def tree_by_name(name)
		file_name = PATH_TO_TREES + name + TREE_EXT
		tree = tree_by_file_name(file_name)		
		tree
	end
	def trees
		tree_files = Dir[PATH_TO_TREES + "*" + TREE_EXT]
		tree_files.sort!
		tree_files.map! do |path|
			tree_by_file_name(path)
		end
		tree_files
	end

	private

	def tree_by_file_name(path)
		tree = File.read(path)
		tree = JSON.parse(tree)
		tree = TreeGrower.grow(tree)
	end
end
