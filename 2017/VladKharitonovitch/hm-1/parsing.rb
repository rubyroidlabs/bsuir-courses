@after_parsing_arr=[]
  def parsing (array)
    array_of_nodes=[]
    current_list=[]
    array.each do |x|
    if  x.class.to_s != "Array"
        current_list.push(x)
    else
        array_of_nodes += x
    end
    end
    if current_list.empty? == false 
      @after_parsing_arr<<current_list
    end
    if array_of_nodes.size != 0
      parsing(array_of_nodes)
    end
end