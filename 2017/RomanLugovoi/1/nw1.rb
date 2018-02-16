puts ENV['NAME']

treename = ENV['NAME']

fname = File.file?("trees/#{treename}.tree")

if treename.nil?
  puts 'Безымянных деревьев у нас не растет'
elsif !fname
  puts 'Данное дерево не растет в данном лесу'
else
  tree = File.new("trees/#{treename}.tree")
  puts tree.read
end
