def cut_tree(tree, depth, result)
  tree.each do |tree_branch|
    if tree_branch.is_a? Array
      cut_tree(tree_branch, depth + 1, result)
    else
      result[depth].push(tree_branch)
    end
  end
end

def draw_tree(name)
  tree_file = File.read("./trees/#{name}")
  require 'json'
  tree_array = JSON.parse(tree_file)
  cutted_tree = Array.new(100) { [] }
  cut_tree(tree_array, 0, cutted_tree)
  cutted_tree.delete_if { |element| element.count.zero? }
  drawed_tree = []
  cutted_tree.each_with_index do |layer, index|
    drawed_line = ''
    depth = cutted_tree.count
    slash_line = ''
    drawed_line << ' ' * (2**(depth - index) - 2)
    slash_line << ' ' * (2**(depth - index) - 2)
    layer.each do |node|
      drawed_line << (node / 10 > 0 ? node / 10 : ' ').to_s
      drawed_line << (node % 10).to_s
      slash_line << '/\\'
      slash_line << ' ' * (2**(depth - index + 1) - 2)
      drawed_line << ' ' * (2**(depth - index + 1) - 2)
    end
    drawed_tree.push(drawed_line)
    drawed_tree.push(slash_line) if index != cutted_tree.count - 1
  end
  puts drawed_tree
end
tree_name_without_extension = ENV['name']
if tree_name_without_extension.nil?
  puts 'Безымянных деревьев у нас не растет'
elsif !File.exist?("./trees/#{tree_name_without_extension}.tree")
  puts 'Это дерево у нас не растет'
else
  tree_name = "#{ENV['name']}.tree"
  puts tree_name
  draw_tree(tree_name)
end
