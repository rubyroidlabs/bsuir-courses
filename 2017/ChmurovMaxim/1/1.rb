a = [23,[[7,[[21,[[4,[39,7]],[44,[39,19]]]],[20,[[14,[7,35]],[6,[0,15]]]]]],
[3,[[13,[[8,[38,48]],[24,[1,38]]]],[4,[[32,[3,4]],[1,[18,24]]]]]]]]
levels={}
def func(arr, levels, level) 
  if arr.is_a? Numeric
    if levels[level.to_s].is_a? Array
      levels[level.to_s] << arr
    else
      levels[level.to_s] = [arr]
    end
  else
    func(arr.first, levels, level + 1)
    func(arr.last, levels, level + 1)
  end
end
func(a, levels, 0)
max = levels[levels.keys.last].count * 8
levels.keys.each do |key|
  count = levels[key].count * 2
  interval = max / count
  index = 1
  if levels[key].count > 1
    levels[key].each do
      slash_interval_right = interval / 2
      slash_interval_right -= 1
      slash_interval_left = interval / 2
      if (index % 2).zero?
        slash = '\\'
      else 
        slash = '/'
      end
      index += 1
      print "#{' ' * slash_interval_right}#{slash}#{' ' * slash_interval_left}"
    end
  end
  puts
  levels[key].each do |val|
    interval_right = interval / 2
    interval_right -= 1
    interval_left = interval / 2    
    if val.to_s.length == 2
      interval_left -= 1
    end
    print "#{' ' * interval_right}#{val}#{' ' * interval_left}"
  end
  puts
end
