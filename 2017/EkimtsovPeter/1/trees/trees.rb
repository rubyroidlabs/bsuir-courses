def file_check(file_name)
  if File.exist?("#{file_name}.tree")
    l_sum_ch(h_l_sum(h_spc_clr(h_clr(s_to_h(File.read("#{file_name}.tree"))))))
  elsif file_name.nil?
    puts 'Write a file name, please!'
  else
    all_trees_out
  end
end

def dir_check
  files = []
  curr_dir = Dir.pwd
  file_list = Dir.entries(curr_dir)
  file_list.sort!
  file_list.each do |filename|
    files.push(filename) if filename =~ /.tree/
  end
  files
end

def all_trees_out
  dir_check.each do |filename|
    str = File.read(filename.to_s)
    puts "Want to continue? [y/n] #{filename}: "
    input = gets.chomp
    case input
    when 'y' then l_sum_ch(h_l_sum(h_spc_clr(h_clr(s_to_h(str)))))
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
  h_rev(levels_hash)
end

def h_l_sum(hash)
  arr_output = []
  sum = 0
  size = hash.size
  hash.each_value do |value|
    value.split(' ').each do |elem|
      sum += elem.to_i
    end
  end
  arr_output.push(sum).push(size).push(hash)
  arr_output
end

def l_sum_ch(arr)
  size = arr[1]
  sum = arr[0]
  hash = arr[-1]
  h_value_out(hash)
  if size > 5 || sum > 5000
    puts "Tree size is #{size}.Tree sum is #{sum}. We need to cut it"
  else
    puts "Tree size is #{size}.Tree sum is #{sum}. We don't need to cut it"
  end
end

def h_rev(hash)
  Hash[hash.to_a.reverse]
end

def h_clr_a(hash)
  hash.each_value do |value|
    value.each_char do |char|
      value.delete!(char) if %w([ ]).include?(char)
    end
  end
  hash
end

def h_spc_clr(hash)
  h_clr(hash)
  hash.each_value do |value|
    value.strip!
    value.squeeze!(' ')
  end
  hash
end

def center_counter(hash)
  r_hash = h_rev(hash)
  r_hash.each_value do |value|
    return value.length
  end
end

def h_value_out(hash)
  hash.each_value do |value|
    puts(puts(value.center(center_counter(hash))))
  end
end

def h_clr(hash)
  hash.each_value do |value|
    value.each_char do |char|
      value.delete!(char) if %w([ " '\' , ]).include?(char)
    end
  end
  hash
end

file_check(ENV['NAME'])
