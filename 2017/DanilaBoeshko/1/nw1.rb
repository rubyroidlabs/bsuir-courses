puts ENV['NAME']

name = ENV['NAME']

def convert; end

filename = File.file?("trees/#{name}.tree")

if name.nil?
  trees_arr = Dir['trees/**']
  trees_arr.sort!
  puts trees_arr[0]
  (1...trees_arr.count).each do |tree_num|
    puts File.read(trees_arr[tree_num])
  end
elsif !filename
  puts 'Данное дерево не растет в данном лесу'
else
  tree = File.new("trees/#{name}.tree")
  puts tree.read
end