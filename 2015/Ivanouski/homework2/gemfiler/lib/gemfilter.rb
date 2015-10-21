class GemFilter
  def initialize
    @clz = Colorizer.new()
  end

  def filter(gems_output, op, ver)
    gems_output.each do |i|
    temp = i['number']
      if op == '<' &&
      i['number'] < ver
        @clz.push_colored i['number']
      elsif op == '>' &&
      i['number'] > ver
        @clz.push_colored i['number']
      elsif op == '>=' &&
      i['number'] >= ver
        @clz.push_colored i['number']
      elsif op == '~>' &&
      i['number'] >= ver && temp[2] == ver[2] && temp[0] == ver[0]
        @clz.push_colored i['number']
      else
        @clz.push_original i['number']
      end
    end
  end

  def filter_long (gems_output, op1, ver1, op2, ver2)
    gems_output.each do |i|
      temp = i['number']
      if op1 == '>=' && op2 == '<' &&
      i['number'] >= ver1 && i['number'] < ver2
        @clz.push_colored i['number']
      elsif op1 == '>' && op2 == '<' &&
      i['number'] > ver1 && i['number'] < ver2
        @clz.push_colored i['number']
      else
        @clz.push_original i['number']
      end
    end
  end
end
