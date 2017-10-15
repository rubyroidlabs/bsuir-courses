require 'zip/zip'
require 'rubygems'
require 'zip'
require 'json'
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

def print_slash(levels, interval, key, index)
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
      if slash_interval_right < 1
        slash_interval_right = 1
      end
      if slash_interval_left < 1
        slash_interval_left = 1
      end
      index += 1
      print "#{' ' * slash_interval_right}#{slash}#{' ' * slash_interval_left}"
    end
  end
end

def print_digit(levels, interval, key, max_count)
  levels[key].each do |val|
    interval_right = interval / 2
    interval_right -= 1
    interval_left = interval / 2
    if val.to_s.length == 2
      interval_left -= 1
    end
    print "#{' ' * interval_right}#{val}#{' ' * interval_left}"
    max_count += val
  end
  return max_count
end

def print_tree(tree, levels, max_count)
  if tree.name != 'trees/'
    a = tree.get_input_stream.read
    a = JSON.parse(a)
    func(a, levels, 0)
    max = levels[levels.keys.last].count * 8
    levels.keys.each do |key|
      count = levels[key].count * 2
      interval = max / count
      print_slash(levels, interval, key, 1)
      puts
      max_count = print_digit(levels, interval, key, max_count)
      puts
    end
    if levels.keys.count > 5
      puts 'clip'
    elsif max_count > 5000
      puts 'chop down'
    else
      puts 'leave'
    end
  end
end

Zip::File.open("trees.zip") do |zipfile|
  zipfile.each do |tree|
    puts 'continue? y/n'
    if gets.chomp == 'y'
      print_tree(tree, {}, 0)
    else
      exit(0)
    end
  end
end

