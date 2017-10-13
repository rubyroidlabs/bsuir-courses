require 'json'

def hacked_tree(tree, lvl_deep, closing_tree)
  if tree[0].is_a? Array
    hacked_tree(tree[0], lvl_deep + 1, closing_tree)
  else
    closing_tree[lvl_deep].push(tree[0])
  end

  if tree[1].is_a? Array
    hacked_tree(tree[1], lvl_deep + 1, closing_tree)
  else
    closing_tree[lvl_deep].push(tree[1])
  end
end

def printer(name)
  file_tree = File.read("./trees/#{name}")
  arr_tree = JSON.parse(file_tree)
  slashed_tree = Array.new(1000) { [] }
  hacked_tree(arr_tree, 0, slashed_tree)
  slashed_tree.delete_if do |item|
    item.count.zero?
  end
  console_tree = []
  slashed_tree.each_with_index do |depth_lvl, index|
    console_line = ''
    slash_line = ''
    depth_lvl = slashed_tree.count
    console_line = console_line << ' ' * (2**(depth_lvl - index) - 2)
    slash_line << ' ' * (2**(depth_lvl - index) - 2)
    slashed_tree[index].each do |node|
      console_line << (node / 10 > 0 ? node / 10 : ' ').to_s
      slash_line << '/\\' << ' ' * (2**(depth_lvl - index + 1) - 2)
      console_line << (node % 10).to_s
      console_line << ' ' * (2**(depth_lvl - index + 1) - 2)
    end
    console_tree.push(console_line)
    console_tree.push(slash_line) unless index == slashed_tree.count - 1
  end
  puts console_tree
end
