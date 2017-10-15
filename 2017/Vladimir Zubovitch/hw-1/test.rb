def draw(tree)
  tree.each do |lvl|
    sp = 128 / (lvl.size + 1)
    sp += 1
      if tree[0] != lvl
        lvl.size.times do |i|
          if (i % 2).zero?
            print "%#{sp}s" % ["/"]
          else
            print "%#{sp}s" % ["\\"]
          end
        end
      end
    puts
    lvl.size.times do |i|
      print "%#{sp}s" % [lvl[i]]
    end
    puts
  end
end

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
    $list_arr << list_now 
  end
  if arr_node.size.empty?
    base(arr_node)
  end
end

#!/usr/bin/env ruby
require 'json'
input = ENV["NAME"].to_s.downcase
$list_arr = []
  if input.empty?
    puts 'problem'
  else
    garden = []
    Dir.foreach('trees') { |x| garden << x }
    if garden.include?("#{input}.tree")
      puts "Есть такое дерево"
      f = File.new ("trees/#{input}.tree")
      content = f.read
      b = JSON.parse(content)
      base(b)
      filtred_array = $list_arr
      draw(filtred_array)
    end
  end
