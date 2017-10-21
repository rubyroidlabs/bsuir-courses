@after_parsing_arr = []
def parsing (array)
  array_of_nodes = []
  current_list = []
  array.each do |x|
    if  x.is_a? Array
      array_of_nodes += x
    else
      current_list.push(x)
    end
  end
  if current_list.empty? == false 
    @after_parsing_arr<<current_list
  end
  if array_of_nodes.size !=0
    parsing(array_of_nodes)
  end
end