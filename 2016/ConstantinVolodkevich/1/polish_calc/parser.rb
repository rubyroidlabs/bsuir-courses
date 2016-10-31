class Parser

  def clean_string(string)
    string.slice!(0) if string[0] == "/"
    elements = string.split(' ').map!{|e| e.gsub(/[^[*\-\*\+\!\/\^\d+(\.\d+)*$]]|[@#\$%\^&\||(\)\[\]:;]/,'')}.reject{|item| item == '.' || item == '' || item == '...'}

    if elements.any?{|i| i =~ /(\d+(\.\d+)?)/?true:false}
      elements
    else
      "Error"
    end
  end

  def initial_equation(string)

    equation = clean_string(string)
    if equation.is_a? String
      equation
    else
      equation.join(" ")
    end

  end
end


