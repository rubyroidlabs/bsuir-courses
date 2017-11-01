# this class prints tree
class TreePrinter
  def initialize(parsed_tree)
    @parsed_tree = parsed_tree
    @rendered_tree = []
    @depth = @parsed_tree.count
  end

  def render
    @parsed_tree.each_with_index do |layer, index|
      padding_left = ' ' * (2**(@depth - index + 1) - 2)
      numbers_level = padding_left.clone
      pointers_level = padding_left.clone
      put_info(pointers_level, numbers_level, layer, index)
      @rendered_tree.push(pointers_level) unless index.zero?
      @rendered_tree.push(numbers_level)
    end
    @rendered_tree
  end

  private

  def put_info(pointers_level, numbers_level, layer, index)
    pointers = ['/', '\\']
    layer.each_with_index do |element, inner_index|
      pointers_level << if inner_index.even?
                          " #{pointers[inner_index % 2]}"
                        else
                          "#{pointers[inner_index % 2]} "
                        end
      padding_between = ' ' * (2**(@depth - index + 2) - 2)
      pointers_level << padding_between
      numbers_level.concat(numeric_to_str(element), padding_between)
    end
  end

  def numeric_to_str(numeric)
    '' << (numeric / 10 > 0 ? numeric / 10 : ' ').to_s \
      << (numeric % 10).to_s
  end
end
