require 'json'
class Menu
  def menu(file_stream, tree, file_name)
    Dir.chdir('trees')
    if !file_name
      menu_forest(file_stream, tree)
    elsif File.exist?(file_name)
      menu_single_tree(file_stream, file_name, tree)
    else
      p 'There are no such trees in our forest.'
    end
    p 'Thank you for visiting in our forest.'
  end

  def menu_forest(file_stream, tree)
    array_trees = load_forest.sort
    array_trees.each do |index|
      if array_trees.to_s[index].include?('.tree')
        menu_single_tree(file_stream, array_trees.to_s[index], tree)
        unless extension_check
          break
        end
      end
    end
  end

  def menu_single_tree(file_stream, file_name, tree)
    array = file_stream.get_parsed_file(file_name)
    tree.initialization(array, 0, tree.create_root, 1)
    p "==={#{file_name}}==="
    tree.get_tree(tree.tree_root)

    if tree.count_sum_nodes(tree.tree_root) > 5000
      p 'To cut down.'
      File.delete(file_name)
    elsif !tree.check_depth(tree.tree_root)
      p 'Crop.'
      tree.crop(tree.tree_root)
      tree.get_tree(tree.tree_root)
      p 'Cropped tree.'
    else
      p 'Leave.'
    end
  end

  def get_directory
    directory = Dir.new(Dir.pwd)
  end

  def load_forest
    Dir.entries(get_directory)
  end

  def extension_check
    loop do
      p 'Would you like to continue browsing the trees?(y/n)'
      answer = gets.chomp
      flg = nil
      flg = case answer.to_s
              when 'yes', 'Yes', 'y', 'YES'
                true
              when 'No', 'no', 'n', 'Not', 'not', 'NO', 'NOT'
                false
              else
                nil
            end
      if flg == nil
        p 'Input Error. Try again.'
      else
        return flg
      end
    end
  end
end