require_relative 'tree'

module Lumberjack
  module_function

  def think(tree)
    if tree.age > 100
      'Cut down. This is the ' + 'very ' * (tree.age / 1000) + 'old tree.'
    elsif tree.height > 5
      'Prune. It is too high.'
    else
      'Leave it.'
    end
  end
end
