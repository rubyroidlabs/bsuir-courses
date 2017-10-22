# this class prints tree
class TreePrinter
  def initialize(parsed_tree)
    @parsed_tree = parsed_tree
    @rendered_tree = []
  end

  def render
    depth = @parsed_tree.count
    @parsed_tree.each_with_index do |layer, index|
      padding_left = ' ' * (2**(depth - index + 1) - 2)
      numbers_level = '' << padding_left
      pointers_level = '' << padding_left
      pointers = ['/', '\\']
      layer.each_with_index do |element, inner_index|
        if inner_index.even?
          pointers_level << ' ' << pointers[inner_index % 2]
        else
          pointers_level << pointers[inner_index % 2] << ' '
        end
        padding_between = ' ' * (2**(depth - index + 2) - 2)
        inner_index != (layer.count - 1) &&
          pointers_level << padding_between
        numbers_level << numeric_to_str(element)
        inner_index != (layer.count - 1) &&
          numbers_level << padding_between
      end
      @rendered_tree.push(pointers_level) unless index.zero?
      @rendered_tree.push(numbers_level)
    end
    @rendered_tree
  end

  private

  def numeric_to_str(numeric)
    '' << (numeric / 10 > 0 ? numeric / 10 : ' ').to_s \
      << (numeric % 10).to_s
  end
end
