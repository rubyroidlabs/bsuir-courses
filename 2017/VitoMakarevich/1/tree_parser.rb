require 'json'
# this class parses tree from multidimensional array and returns by layers
class TreeParser
  attr_accessor :depth

  def initialize(text)
    @array = JSON.parse(text)
  end

  def parse_layers
    layers_from_array
    @layers
  end

  private

  def layers_from_array
    depth = array_depth
    @layers = Array.new(depth) { [] }
    parse(@array[1], 0)
    @layers[0].push(@array[0])
    @layers.delete_if { |layer| layer.count.zero? }
  end

  def parse(tree, level)
    tree.each do |elem|
      if elem.is_a? Array
        parse(elem, level + 1)
      else
        @layers[level].push(elem)
      end
    end
  end

  def array_depth
    b = @array
    depth = 1
    until b == b.flatten
      depth += 1
      b = b.flatten(1)
    end
    depth
  end
end
