# /usr/bin/env ruby

tree_name = ENV['NAME']
arr = []
str = ''
file_name = 'trees/' + tree_name + '.tree'
File.open(file_name) do |file|
  file = file.read
  arr = file.scan(/\d\d*/)
  str = file.delete '0-9'
end

vertex = 1
i = 0
j = 0
max = vertex
tree = []
tree[vertex] = arr[j]
while i < str.size - 1
  if str[i] + str[i + 1] == ',['
    vertex *= 2

    unless tree[vertex * 2].nil?
      vertex += 1
    end

    j += 1
    tree[vertex] = arr[j]
  elsif str[i] == ','
    vertex += 1
    j += 1
    tree[vertex] = arr[j]
  elsif str[i] == ']'
    if !tree[vertex * 2].nil? && tree[(vertex * 2) + 1].nil?
      vertex *= 2
    end
    vertex /= 2
  end
  i += 1
  if max < vertex
    max = vertex
  end
end

met = max
count = 0
while met != 0
  count += 1
  met /= 2
end

i = 1
vertex = 1
while max != 0
  print ' ' * (max - 1)
  met = 0
  while met != i
    print tree[vertex]
    if tree[vertex].to_i < 10
      print ' ' * (2**(count + 1) - 1)
    else
      print ' ' * (2**(count + 1) - 2)
    end
    vertex += 1
    met += 1
  end
  i *= 2
  max /= 2
  count -= 1
  print "\n\n"
end
