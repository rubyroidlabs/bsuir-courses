require 'rubygems'
require 'zip'
require 'json'

def number? string
  true if Float(string) rescue false
end

def build_tree_divide_and_conquer(tree_array, level_of_depth, branch_dir)
  l = tree_array[0]
  r = tree_array[1]
  @maximal_depth = level_of_depth > @maximal_depth ? level_of_depth
    : @maximal_depth
  if l.is_a?(Integer)
    @a[level_of_depth].push([l, branch_dir])
    @vertex_sum += l
    level_of_depth += 1
  end

  if r.is_a?(Integer)
    if l.is_a?(Integer)
      level_of_depth -= 1
    end
    @a[level_of_depth].push([r, branch_dir])
    @vertex_sum += r
  end

  if l.is_a?(Array)
    build_tree_divide_and_conquer(l, level_of_depth, 'l')
  end

  if r.is_a?(Array)
    build_tree_divide_and_conquer(r, level_of_depth, 'r')
  end
end

def build_print_tree
  19.times do
    @a.push([])
  end
end

def print_tree
  n = @maximal_depth
  (0..2 * (2**(n - 1))).each do |i|
    print ' '
  end
  print @a[1][0][0]
  puts

  (1..n - 1).each do |i|
    str = String.new('')
    count = 0
    # Print values
    (1..(2**(n - i) - 1)).each do
      str += ' '
    end
    str += @a[i + 1][count][0].to_s
    count += 1
    k = 1
    (1..(2**i) - 1).each do
      (1..2**(n - i + 1) - 1).each do
        str += ' '
      end
      if k.zero?
        str += @a[i + 1][count][0].to_s
        count += 1
        k = 1
      else
        str += @a[i + 1][count][0].to_s
        count += 1
        k = 0
      end
    end

    flag = false
    k = 0
    str.split('').each do |j|
      if number?(j) && !flag
        if k.zero?
          print '/'
          k = 1
        else
          print '\\'
          k = 0
        end
        flag = true
      elsif number?(j) && flag
        print ' '
      elsif j == ' '
        print ' '
        flag = false
      end
    end
    puts
    puts str
  end
end

def make_choise
  puts
  if @vertex_sum > 5000
    puts 'Срубить'
  elsif @maximal_depth > 5
    puts 'Обрезать'
  else
    puts 'Оставить его как есть'
  end
end

def level3
  Zip::File.open('trees.zip') do |zip_file|
    zip_file.each do |entry|
      next if entry.directory?
      puts entry.name
      content = entry.get_input_stream.read
      @a = []
      build_print_tree
      @vertex_sum = 0
      @maximal_depth = 0
      parsed_json_tree = JSON.parse(content)
      build_tree_divide_and_conquer(parsed_json_tree, 1, 'c')
      print_tree
      make_choise
      puts "\nХотите продолжить? [y/n]: "
      user_ans = gets.to_s
      user_ans[0] = user_ans[0].downcase
      if user_ans[0] == 'n'
        p 'Спасибо, что были в нашем лесу!'
        break
      end
    end
  end
end
# =>                                           BEGINNING
::Zip.sort_entries = true
puts 'Добро пожаловать в наш лес!'
name = ENV['NAME']
if name.nil?
  level3
else
  Zip::File.open('trees.zip') do |zip_file|
    if zip_file.find_entry("trees/#{name}.tree")
      content = zip_file.read("trees/#{name}.tree")
      @a = []
      build_print_tree
      @vertex_sum = 0
      @maximal_depth = 0
      parsed_json_tree = JSON.parse(content)
      build_Tree_Divide_And_Conquer(parsed_json_tree, 1, 'c')
      print_Tree
    else
      puts 'Данное дерево тут не растёт!'
    end
    puts 'Спасибо, что были в нашем лесу!'
  end
end
