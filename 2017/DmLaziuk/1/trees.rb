require 'zip'
require 'json'

# @n -- depth of tree
@n = 0

# @hash -- hash table with coordinates and value of each node of the tree
#          { [y, x] = value }
@hash = Hash.new([0, 0])

# @x -- temporary array of current x for current level y
#       needed for recursion function parse()
#       x[y] = current x
#       10 -- maximum depth of the tree
@x = Array.new(10) { 0 }

# parse -- recursively parse all nodes of the tree, stored in arr[]
#          and form hash table @hash = { [y, x] = value }
#            y -- level of the tree (0 -- root)
#            x -- x position in tree (0...2**y)
#
# arguments:
#   arr -- array representing tree
#          for example
#          arr = [1 ,[[2 ,[4 , 5 ]],[3,[6,7]]]]
#          is for tree:
#             1
#            /  \
#           2    3
#          / \  / \
#         4  5 6  7
#
#   lvl -- current level
#          start parse from lvl = 0 (root)
#
def parse(arr, lvl = 0)
  @n = lvl > @n ? lvl : @n
  left = arr[0]
  right = arr[1]

  if left.is_a?(Integer) && right.is_a?(Array)
    # node [Integer, Array]
    @hash[[lvl, @x[lvl]]] = left
    @x[lvl] += 1
    parse(right, lvl + 1)
  elsif left.is_a?(Array) && right.is_a?(Array)
    # node [Array, Array]
    parse(left, lvl)
    parse(right, lvl)
  else
    # node [Integer, Integer]
    @hash[[lvl, @x[lvl]]] = left
    @x[lvl] += 1
    @hash[[lvl, @x[lvl]]] = right
    @x[lvl] += 1
  end
end

# environment variable NAME='tree_name'
name = ENV['NAME']

if name
  Zip::File.open('trees.zip') do |zip_file|
    if zip_file.find_entry("trees/#{name}.tree")
      tree = JSON.parse(zip_file.read("trees/#{name}.tree"))
      parse(tree)
      # preparing string array to output
      str = []
      # initialize each string with 4 spaces for 2**n elements
      (0..2 * @n).each { |i| str[i] = '    ' * 2**@n }
      # print branches /\
      (0...@n).each do |y|
        (0...2**y).each do |x|
          # curr_str -- every odd line in str[]
          curr_str = str[2 * y + 1]
          # curr_x -- offset from the beginning of line
          curr_x = 2**(@n + 1 - y) + x * 2**(@n + 2 - y) + 1
          curr_str[curr_x, 2] = '/\\'
        end
      end
      # print nodes with values
      @hash.each do |yx, value|
        # (y, x) -- coordinates of node
        y = yx[0]
        x = yx[1]
        # curr_str -- every even line in str[]
        curr_str = str[2 * y]
        curr_x = 2**(@n + 1 - y) + x * 2**(@n + 2 - y)
        curr_str[curr_x, 4] = format('%3d ', value)
      end
      str.each { |s| puts s }
    else
      puts 'Данное дерево не растет в данном лесу.'
    end
  end
else
  puts 'Безымянных деревьев у нас не растет.'
end
