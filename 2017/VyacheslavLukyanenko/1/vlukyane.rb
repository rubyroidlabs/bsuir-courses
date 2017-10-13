require 'rubygems'
require 'zip'
require 'json'

def is_number? string
  true if Float(string) rescue false
end

def build_Tree_Divide_And_Conquer(tree_Array, level_Of_Depth, branch_Dir)

  l = tree_Array[0]
  r = tree_Array[1]
  @maximal_depth = level_Of_Depth > @maximal_depth? level_Of_Depth : @maximal_depth
  if (l.is_a?(Integer))
    @a[level_Of_Depth].push([l, branch_Dir])
    @vertex_sum += l
    level_Of_Depth += 1
  end

  if r.is_a?(Integer)
    if l.is_a?(Integer)
      level_Of_Depth -= 1
    end
    @a[level_Of_Depth].push([r, branch_Dir])
  end
    @vertex_sum += r

  if l.is_a?(Array)
    build_Tree_Divide_And_Conquer(l, level_Of_Depth, 'l')
  end

  if r.is_a?(Array)
    build_Tree_Divide_And_Conquer(r, level_Of_Depth, 'r')
  end
end

def build_Print_Tree
  19.times do
    @a.push([])
  end
end

def print_Tree
  n = @maximal_depth
  (0..2 * (2 ** (n - 1))).each do |i|
    print ' '
  end
  print @a[1][0][0]
  puts

  (1 .. n - 1).each do |i|
    str = String.new('')
    count = 0
    # Вывод значений
    (1..(2 ** (n - i) - 1)).each do
      str += ' '
    end
    str += @a[i + 1][count][0].to_s
    count += 1
    k = 1
    (1 .. (2 ** i) - 1).each do
      (1..2 ** (n - i + 1) - 1).each do
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
    str.split('').each do |i|
      if is_number?(i) && !flag
        if k.zero?
          print '/'
          k = 1
        else
          print '\\'
          k = 0
        end
        flag = true
      elsif is_number?(i) && flag
        print ' '
      elsif i == ' '
        print ' '
        calc += 1
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
      build_Print_Tree
      @vertex_sum = 0
      @maximal_depth = 0
      parsed_json_tree = JSON.parse(content)
      build_Tree_Divide_And_Conquer(parsed_json_tree, 1, 'c')
      print_Tree
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
      buildPrintTree
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
