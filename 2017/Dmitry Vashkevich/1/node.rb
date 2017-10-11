class Node
  attr_accessor :weight, :left, :right
  def initialize(array)
    if array.is_a? Integer
      @weight = array
      @left = nil
      @right = nil
    else
      @weight = array[0]
      @left = Node.new(array[1][0])
      @right = Node.new(array[1][1])
    end
  end
end
