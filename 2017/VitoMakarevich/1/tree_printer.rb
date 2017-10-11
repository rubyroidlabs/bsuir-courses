# this class prints tree
class TreePrinter
  def initialize(parsed_tree)
    @parsed_tree = parsed_tree
    @rendered_tree = []
  end

  def render
    @parsed_tree.reverse!
    @parsed_tree[0...@parsed_tree.length]
      .each_with_index do |layer, index|
      numbers_level = ''
      numbers_level << ' ' * (2**(index + 1) - 2)
      pointers_level = ''
      pointers_level << ' ' * (2**(index + 1) - 2)
      pointers = ['/', '\\']
      layer.each_with_index do |element, inner_index|
        if inner_index.even?
          pointers_level << ' ' << pointers[inner_index % 2]
        else
          pointers_level << pointers[inner_index % 2] << ' '
        end
        inner_index != (layer.count - 1) &&
          pointers_level << ' ' * (2**(index + 2) - 2)
        numbers_level << (element / 10 > 0 ? element / 10 : ' ').to_s
        numbers_level << (element % 10).to_s
        inner_index != (layer.count - 1) &&
          numbers_level << ' ' * (2**(index + 2) - 2)
      end
      @rendered_tree.push(numbers_level)
      @rendered_tree.push(pointers_level) if index != (@parsed_tree.count - 1)
    end
    @rendered_tree.reverse
  end
end
