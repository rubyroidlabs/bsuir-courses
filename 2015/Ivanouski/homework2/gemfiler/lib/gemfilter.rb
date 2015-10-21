class GemFilter
  def filter(gems_output, op, ver)
    gems_output.each do |i|
      vers = i['number']
      if op == '<' &&
      i['number'] < ver
        $ver_array.push (i['number']).red
      elsif op == '>' &&
      i['number'] > ver
        $ver_array.push (i['number']).red
      elsif op == '>=' &&
      i['number'] >= ver
        $ver_array.push (i['number']).red
      elsif op == '~>' &&
      i['number'] >= ver &&
      vers[2] == ver[2] &&
      vers[0] == ver[0]
        $ver_array.push (i['number']).red
      else
        $ver_array.push i['number']
      end
    end
  end

  def filter_long(gems_output, op1, ver1, op2, ver2)
    gems_output.each do |i|
      vers = i['number']
      if op1 == '>=' &&
      op2 == '<' &&
      i['number'] >= ver1 &&
      i['number'] < ver2
        $ver_array.push (i['number']).red
      elsif op1 == '>' &&
      op2 == '<' &&
      i['number'] > ver1 &&
      i['number'] < ver2
        $ver_array.push (i['number']).red
      else
        $ver_array.push i['number']
      end
    end
  end
end
