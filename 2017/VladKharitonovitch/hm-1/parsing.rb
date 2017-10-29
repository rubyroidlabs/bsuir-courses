@after_parsing_arr = []
def parsing(array)
  array_of_nodes = []
  current_list = []
  array.each do |x|
    if x.is_a? Array
      array_of_nodes += x
    else
      current_list.push(x)
    end
  end
  @after_parsing_arr << current_list if current_list.empty? == false
  parsing(array_of_nodes) unless array_of_nodes.empty?
end
