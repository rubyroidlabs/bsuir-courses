require 'json'
class TreeParser
  attr_accessor :depth

  def sum
    sum = 0
    @layers.each { |layer| layer.each { |item| sum += item } }
    sum
  end

  def initialize(text)
    @text = text
    @array = JSON.parse(text)
  end

  def get_layers 
    get_array
    @layers
  end

  private

  def get_array
    @depth = array_depth(@array) - 1
    @layers = Array.new(@depth) { Array.new }
    parse(@array[1], 0)
    @layers[0].push(@array[0])
    @layers.delete_if { |layer| layer.count.zero? }
  end

  def parse(tree, level)
    if tree[0].is_a? Array
      parse(tree[0], level + 1)
    else
      @layers[level].push(tree[0])
    end
    if tree[1].is_a? Array
      parse(tree[1], level + 1)
    else
      @layers[level].push(tree[1])
    end
  end

  def array_depth(array)
    b = array
    depth = 1
    until b == b.flatten
      depth += 1
      b = b.flatten(1)
    end
    depth
  end
end
