module Gardener
  class Recursion
    attr_reader :conv_arr

    def initialize
      @lev = -1
      @stack = [0]
      @conv_arr = []
    end

    def recursion_tree(arr)
      if arr[0].kind_of?(Array)
        left = arr[0]
        right = arr[1]
        @stack << @lev

        recursion_tree(left)

        @lev = @stack.pop
        recursion_tree(right)

      else
        @lev += 1
        @conv_arr[@lev].nil? ? @conv_arr[@lev] = [arr[0]] : @conv_arr[@lev] << arr[0]

        arr[1].kind_of?(Array) ? recursion_tree(arr[1]) : @conv_arr[@lev] << arr[1]
      end
    end
  end
end
