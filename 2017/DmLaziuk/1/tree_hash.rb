class TreeHash
  attr_reader :depth, :sum

  def initialize(arr = [])
    @depth = 0
    @sum = 0
    @hash = Hash.new([0, 0])
    parse(arr, 0, [0])
  end

  def to_s
    str = []
    # initialize each string with 4 spaces for 2**@depth elements
    (0..2 * @depth).each { |i| str[i] = '    ' * 2**@depth }
    # print branches /\
    (0...@depth).each do |y|
      (0...2**y).each do |x|
        # curr_str -- every odd line in str[]
        curr_str = str[2 * y + 1]
        # curr_x -- offset from the beginning of line
        curr_x = 2**(@depth + 1 - y) + x * 2**(@depth + 2 - y) + 1
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
      curr_x = 2**(@depth + 1 - y) + x * 2**(@depth + 2 - y)
      curr_str[curr_x, 4] = format('%3d ', value)
    end
    str.join("\n")
  end

  private

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
  #   x -- array of current x for current level y
  #       x[y] = current x
  #
  def parse(arr, lvl, x)
    if lvl > @depth
      @depth = lvl
      x << 0
    end
    left = arr[0]
    right = arr[1]
    if left.is_a?(Integer) && right.is_a?(Array)
      # node [Integer, Array]
      @hash[[lvl, x[lvl]]] = left
      @sum += left
      x[lvl] += 1
      parse(right, lvl + 1, x)
    elsif left.is_a?(Array) && right.is_a?(Array)
      # node [Array, Array]
      parse(left, lvl, x)
      parse(right, lvl, x)
    else
      # ending branches
      if left
        @hash[[lvl, x[lvl]]] = left
        x[lvl] += 1
        @sum += left
      end
      if right
        @hash[[lvl, x[lvl]]] = right
        x[lvl] += 1
        @sum += right
      end
    end
  end
end
