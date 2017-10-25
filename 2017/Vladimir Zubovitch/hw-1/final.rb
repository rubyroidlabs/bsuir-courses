# !/usr/bin/env ruby
require 'json'
def base(tree)
  arr_node = []
  list_now = []
  tree.each do |node|
    if node.class.to_s != 'Array'
      list_now << node
    else
      arr_node += node
    end
  end
  if list_now != []
    @list_arr << list_now
  end
  unless arr_node.size.zero?
    base(arr_node)
  end
end

def draw(tree)
  tree.each do |lvl|
    space = 128 / (lvl.size + 1)
    space += 1
    if tree[0] != lvl
      lvl.size.times do |i|
        if (i % 2).zero?
          format("%#{space}s", '/')
        else
          format("%#{space}s", '\\')
        end
      end
    end
    puts
    lvl.size.times do |i|
      format("%#{space}s", lvl[i])
    end
    puts
  end
end

input = ENV['NAME'].to_s.downcase
@list_arr = []
if input.empty?
  puts 'problem'
else
  garden = []
  Dir.foreach('trees') { |x| garden << x }
  if garden.include?("#{input}.tree")
    puts 'Есть такое дерево'
    f = File.new "trees/#{input}.tree"
    content = f.read
    b = JSON.parse(content)
    base(b)
    filtred_array = @list_arr
    draw(filtred_array)
  end
end
