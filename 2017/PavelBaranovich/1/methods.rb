# /usr/bin/env ruby

def get_slash_line(depth, space_count, max_depth, numbers_line)
  answer = ' ' * numbers_line.size
  i = space_count
  indent = 1 << (max_depth - depth)
  distance = indent << 3
  while i < numbers_line.size
    answer[i - indent - 1] = '/'
    answer[i + indent - 1] = '\\'
    i += distance
  end

  answer
end

def get_numbers_line(depth, space_count, prev_space_count, tree)
  count = 1 << depth
  answer = ' ' * prev_space_count
  space_count -= 1
  while count < (1 << (depth + 1))
    answer += tree[count] + ' ' * space_count
    answer += ' ' if tree[count].to_i < 10

    count += 1
  end

  answer
end

def print_tree(depth, space_count, prev_space_count, tree, max_depth)
  return if depth < 0

  print_tree(depth - 1, 2 * space_count + 1, space_count - 1, tree, max_depth)

  numbers_line = get_numbers_line(depth, space_count, prev_space_count, tree)

  puts get_slash_line(depth, space_count, max_depth, numbers_line) if depth > 0

  puts numbers_line
end

def create_tree(numbers, str)
  vertex = 1
  i = 1
  j = 0

  tree = []
  tree[vertex] = numbers[0]
  while i < str.size - 1
    if str[i] + str[i + 1] == ',['
      vertex <<= 1

      vertex += 1 unless tree[vertex << 1].nil?

      j += 1
      tree[vertex] = numbers[j]
    elsif str[i] == ','
      vertex += 1
      j += 1
      tree[vertex] = numbers[j]
    elsif str[i] == ']'
      vertex <<= 1 if !tree[vertex << 1].nil? && tree[(vertex << 1) + 1].nil?
      vertex >>= 1
    end

    i += 1
  end

  tree
end

def get_depth(size)
  depth = 0
  count = size - 1
  while count > 0
    depth += 1
    count >>= 1
  end

  depth
end

def solve(file_name)
  file_name = 'trees/' + file_name

  File.open(file_name) do |file|
    file = file.read
    numbers = file.scan(/\d\d*/)
    str = file.delete('0-9')

    tree = create_tree(numbers, str)

    depth = get_depth(tree.size)

    print_tree(depth - 1, 3, 0, tree, depth - 1)

    numbers
  end
end
