# this class prints tree
class TreePrinter
  def initialize(parsed_tree)
    @parsed_tree = parsed_tree
    @rendered_tree = []
  end

  def render
    @parsed_tree.reverse!
    @parsed_tree.each_with_index do |layer, index|
      numbers_level = '' << ' ' * (2**(index + 1) - 2)
      pointers_level = '' << ' ' * (2**(index + 1) - 2)
      pointers = ['/', '\\']
      layer.each_with_index do |element, inner_index|
        if inner_index.even?
          pointers_level << ' ' << pointers[inner_index % 2]
        else
          pointers_level << pointers[inner_index % 2] << ' '
        end
        inner_index != (layer.count - 1) &&
          pointers_level << ' ' * (2**(index + 2) - 2)
        numbers_level << numeric_to_str(element)
        inner_index != (layer.count - 1) &&
          numbers_level << ' ' * (2**(index + 2) - 2)
      end
      @rendered_tree.push(numbers_level)
      @rendered_tree.push(pointers_level) if index != (@parsed_tree.count - 1)
    end
    @rendered_tree.reverse
  end

  private

  def numeric_to_str(numeric)
    '' << (numeric / 10 > 0 ? numeric / 10 : ' ').to_s \
      << (numeric % 10).to_s
  end
end
