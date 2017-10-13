def file_check(file_name)
  if File.exist?("#{file_name}.tree")
    l_sum_ch(a_l_sum(s_to_h(File.read("#{file_name}.tree"))))
  elsif file_name.nil?
    puts 'Write a file name, please!'
  else
    all_trees_out
  end
end

def dir_check
  curr_dir = Dir.pwd
  file_list = Dir.entries(curr_dir).sort
  file_list.select { |file_name| file_name =~ /.tree$/ }
end

def all_trees_out
  dir_check.each do |filename|
    str = File.read(filename.to_s)
    puts "Want to continue? [y/n] #{filename}: "
    input = gets.chomp
    case input
    when 'y' then l_sum_ch(a_l_sum(s_to_h(str)))
    when 'n' then puts 'Thank you for visiting! Have a good day!'
                  break
    else puts 'Type error!'
         redo
    end
  end
end

def s_cleaner(str)
  str.each_char { |char| str.gsub!(char, ' ') if char == ',' }
end

def s_a_leveler(str)
  str_level = str.scan(/\[\d*\s*\d*\]/).to_s
  s_cleaner(str_level)
end

def s_a_lvl_del(str)
  str.gsub!(/\[\d*\s*\d*\]/, '')
end

def s_to_h(str, lvl = 0, lvl_hash = {})
  level = lvl + 1
  levels_hash = lvl_hash
  levels_hash[level] ||= s_a_leveler(s_cleaner(str))
  if s_a_lvl_del(s_cleaner(str)) =~ /\d/
    levels_hash[level + 1] = s_a_leveler(s_cleaner(str))
    s_to_h(s_a_lvl_del(s_cleaner(str)), level, levels_hash)
  end
  a_clr(levels_hash.values.reverse)
end

def a_l_sum(arr)
  arr_output = []
  sum = 0
  size = arr.length
  arr.each do |value|
    value.split(' ').each do |elem|
      sum += elem.to_i
    end
  end
  arr_output.push(sum, size, arr)
end

def l_sum_ch(arr)
  size = arr[1]
  sum = arr[0]
  arr = arr[-1]
  a_value_out(arr)
  if size > 5 || sum > 5000
    puts "Tree size is #{size}.Tree sum is #{sum}. We need to cut it"
  else
    puts "Tree size is #{size}.Tree sum is #{sum}. We don't need to cut it"
  end
end

def h_rev(hash)
  Hash[hash.to_a.reverse]
end

def a_spc_clr(arr)
  arr.each do |value|
    value.strip!
    value.squeeze!(' ')
  end
  arr
end

def center_counter(arr)
  arr.last.length
end

def a_value_out(arr)
  arr.each do |value|
    puts(puts(value.center(center_counter(arr))))
  end
end

def a_clr(arr)
  arr.each do |value|
    value.gsub!(/\D/, ' ')
  end
  a_spc_clr(arr)
end

file_check(ENV['NAME'])
