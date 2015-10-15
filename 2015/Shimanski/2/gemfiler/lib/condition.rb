# хранит условие и версию
class Condition
  def initialize(cond)
    if ('0'..'9').any? { |i| cond[1] == i }
      @our_version = cond[1..-1]
      @condition = cond[0]
    else
      @our_version = cond[2..-1]
      @condition = cond[0..1]
    end
  end

  def suitable?(another_version)
    sign = compare(another_version)
    if @condition.length == 1
      if sign == @condition
        return true
      else
        return false
      end
    end
    if @condition.length == 2
      if sign == '=='
        return true
      elsif sign == @condition[0]
        return true
      elsif sign != @condition[0]
        return false
      end
    end
  end

  # получаем знак отношения между версиями
  def compare(another_version)
    temp = mini_compare(another_version[0], @our_version[0])
    if temp == '>'
      return '>'
    elsif temp == '<'
      return '<'
    elsif temp == '=='
      temp = mini_compare(another_version[2], @our_version[2])
      if temp == '>'
        return '>'
      elsif temp == '<'
        return '<'
      elsif temp == '=='
        temp = mini_compare(another_version[4], @our_version[4])
        if temp == '>'
          return '>'
        elsif temp == '<'
          return '<'
        elsif temp == '=='
          return '=='
        end
       end
      end
  end

  # сравниваем символы
  def mini_compare(version1, version2)
    if version1 > version2
      return '>'
    elsif version1 < version2
      return '<'
    else
      return '=='
    end
  end
end
