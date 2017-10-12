require "json"

# methods
def convert_to_tree(datajson)
  arr = JSON.parse(datajson)
  tree_arr = []
  row = arr.shift
  arr.flatten!(2)
  tree_arr.push(row)
  
  while true do
    row = arr.select { |i| i.class == Integer }
    if(row != [])
      tree_arr.push(row)
    end
      
    arr.delete_if { |i| i.class == Integer }
    arr.flatten!(1)
    numbers = arr.select {|i| i.class == Integer}
    if (arr.size == numbers.size)
      break
    end
  end 

  tree_arr.push(numbers)
  tree_arr.reverse!
    
  def maker_tree(tree_arr)
    def tab(x)
      x.map! do |i|
        i = i.to_s
        if (i.size == 1)
          i = i + " "
        elsif (i.size == 2)
          i
        end
      end
    end
  
    arr_size = tree_arr.size
    arr = tree_arr.select { |el| el.class == Array}
    
    n, m, i, z, x = 0, 2, 0, 1, 4
    c = 2 ** (arr_size-2)
        
    arr_reverse = []
    while i < arr_size-1
      tab(arr[i])
      arr[i] = " " * n + arr[i].join(" " * m)
      arr_reverse.push(arr[i])      
      slash = " " * z + ("/  \\" + " " * x) * c
      arr_reverse.push(slash)
      
      z = z * 2 + 3
      x = x * 2 + 4
      n = n * 2 + 2
      m = m * 2 + 2
      c /= 2
      i += 1
    end

    arr_reverse = arr_reverse.reverse!
    m /= 2
    last = tree_arr.last
    last = ' ' * (m - 1) + last.to_s
    arr_reverse.unshift(last)
    arr_reverse.each { |el| puts el }

  end
  if tree_arr.size > 7
    puts 'Слишком огромное дерево, не хочется его выводить даже'
    puts "Глубина дерева #{tree_arr.size}"

    sum = 0
    fl_tree = tree_arr.flatten
    fl_tree.each do |i|
      sum += i.to_i
    end
    
    puts "Сумма узлов данного дерева равна #{sum}"
  else
    maker_tree(tree_arr)
  end

  sum = 0

  fl_tree = tree_arr.flatten
  fl_tree.each do |i|
    sum += i.to_i
  end

  if sum > 5000
    puts ' '
    puts 'Срубить'
  elsif tree_arr.size > 5
    puts
    puts 'Обрезать'
  else
    puts ' '
    puts 'Оставить'
  end
end 

# main
evnname = ENV['NAME']
arraytrees = Dir.entries('trees').sort!
arraytrees.delete('.')
arraytrees.delete('..')
if evnname.nil?
  arraytrees.each do |i|
    pathname = 'trees/' + i
    file = File.new(pathname)
    data = file.read
    file.close
    puts ' '
    puts i
    puts ' '
    convert_to_tree(data)
    puts ' '
    print 'Желаете продолжить? [y/n] '
    answer = gets.chomp
    if answer == 'n'
      puts ' '
      puts 'Спасибо, что были в нашем лесу'
      break
    end
  end
else
  fulltreename = evnname + '.tree'
  if arraytrees.include? fulltreename
    pathname = 'trees/' + fulltreename
    file = File.new(pathname)
    data = file.read
    file.close
    convert_to_tree(data)
  else
    puts 'Данное дерево не растет в нашем лесу'
  end
end


















