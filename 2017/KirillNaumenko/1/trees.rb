require 'json'

LAYER_DOWN = 2
LAYER_UP = 1

def recursion_for_tree(tree, depth_lvl, last_tree_element)
  if tree.first.is_a? Array
    recursion_for_tree(tree.first, depth_lvl + 1, last_tree_element)
  elsif last_tree_element[depth_lvl].is_a? Array
    last_tree_element[depth_lvl].push(tree.first)
  else
    last_tree_element[depth_lvl] = [tree.first]
  end

  if tree[1].is_a? Array
    recursion_for_tree(tree[1], depth_lvl + 1, last_tree_element)
  elsif last_tree_element[depth_lvl].is_a? Array
    last_tree_element[depth_lvl].push(tree[1])
  else
    last_tree_element[depth_lvl] = [tree[1]]
  end
end

def print_tree(name)
  get_tree = File.read("./trees/#{name}")
  parse_tree = JSON.parse(get_tree)
  array_tree = []
  recursion_for_tree(parse_tree, 0, array_tree)
  array_tree.delete_if do |item|
    !item || item.count.zero?
  end
  console_tree = []
  array_tree.each_with_index do |_lvl, index|
    console_line = ''
    slash_line = ''
    lvl = array_tree.count
    console_line << ' ' * (2**(lvl - index) - LAYER_DOWN)
    slash_line << ' ' * (2**(lvl - index) - LAYER_DOWN)
    array_tree[index].each do |node|
      console_line << (node / 10 > 0 ? node / 10 : ' ').to_s
      slash_line << '/\\' << ' ' * (2**(lvl - index + LAYER_UP) - LAYER_DOWN)
      console_line << (node % 10).to_s
      console_line << ' ' * (2**(lvl - index + LAYER_UP) - LAYER_DOWN)
    end
    console_tree.push(console_line)
    console_tree.push(slash_line) unless index == array_tree.count - 1
  end
  puts console_tree
end
