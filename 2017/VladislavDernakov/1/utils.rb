require 'json'

require_relative 'models/tree_grower'

PATH_TO_TREES = './trees/'.freeze
TREE_EXT   = '.tree'.freeze

module Utils
  def tree_name
    ENV['NAME']
  end

  def tree_by_name(name)
    file_name = PATH_TO_TREES + name + TREE_EXT
    tree_by_file_name(file_name)
  end

  def trees
    tree_files = Dir[PATH_TO_TREES + '*' + TREE_EXT]
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
    # tree = [1 ,[[2 ,[3 , [1, [2, 4]] ]],[3,[5,2]]]]
    TreeGrower.grow(tree)
  end
end
