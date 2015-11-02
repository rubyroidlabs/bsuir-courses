module Helper
  def little_magic(array)
    # refused to work with negative range (-5..2), dont know why
    array.slice!(0..2)
    5.times { array.slice!(-1) }
    array.uniq!
  end

  def error(message)
    puts message
    exit
  end

  def empty?(str1, str2)
    return true if str1.empty? && str2.empty?
    false
  end

  def merge_elements(a, b)
    a.count.times { |i| a[i] += b[i] }
    return a
  end

  def surname(name)
    name.split(' ')[0]
  end
end
