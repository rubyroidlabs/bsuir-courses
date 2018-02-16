require_relative 'tree'
require 'json'

class Forest
  attr_accessor :path

  def initialize(path)
    @directory_path = path
    @tree_files = nil
  end

  def search(name)
    get_tree(@directory_path + '/' + name + '.tree')
  end

  def length
    @tree_files.length
  end

  def each
    @tree_files = Dir[@directory_path + '/*'].sort if Dir.exist? @directory_path
    iterator = 0
    while iterator < length - 1
      tree = get_tree(@tree_files[iterator])
      yield(tree, iterator) if block_given?
      iterator += 1
    end
  end

  private

  def get_tree(path)
    return unless (File.exist? path) && File.extname(path) == '.tree'
    tree_name = File.basename(path, '.tree')
    tree_nodes = JSON.parse(File.read(path))
    Tree.new(tree_name, tree_nodes)
  end
end
