# additional methods for class fetcher, to decrease ABC metric
module Helper
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
    a
  end

  def surname(name)
    name.split(' ')[0]
  end
end
