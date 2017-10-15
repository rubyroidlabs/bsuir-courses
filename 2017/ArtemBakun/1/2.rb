# /usr/bin/env ruby

def create(arr, str)
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
  end
  tree
end

def get_tree_level(arr)
  size = arr.size
  level = 0
  while size != 0
    level += 1
    size /= 2
  end
  level
end

def tree_show(tree, level, max_vertex)
  i = 1
  vertex = 1
  max_vertex -= 1
  while max_vertex != 0
    print ' ' * (max_vertex - 1)
    met = 0
    while met != i
      print tree[vertex]
      if tree[vertex].to_i < 10
        print ' ' * (2**(level + 1) - 1)
      else
        print ' ' * (2**(level + 1) - 2)
      end
      vertex += 1
      met += 1
    end
    i *= 2
    max_vertex /= 2
    level -= 1
    print "\n\n"
  end
end