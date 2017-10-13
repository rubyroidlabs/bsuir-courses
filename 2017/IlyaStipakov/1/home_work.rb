require 'json'

@hash = Hash.[]
@array_of_level = Array.[]
@answer = true
@tree_array = Array.[]
@number = 0
@level = 0

def transform(arr)
  first = arr[0]
  second = arr[1]
  if first.class == Integer && second.class == Array
    @hash[[@level, @number]] = first
    @number += 1
    @level += 1
    transform(second)
  elsif first.class == Array && second.class == Array
    if !first.nil?
      lvl = @level
      transform(first)
    end
    @level = lvl
    transform(second)
  elsif first.class == Integer && second.class == Integer
    @hash[[@level, @number]] = first
    @number += 1
    @hash[[@level, @number]] = second
    @number += 1
  end
end

def print_tree
  str = ' '
  if @hash.size > 1000
    puts 'Это дерево было слишком старое мы его срубили'
  end
  for i in 0..@level
    for n in 0..2**(@level + 1)
      if @hash[[i, n]] != nil
        str << ' ' * (2**(@level - i))
        str << @hash[[i, n]].to_s
        str << ' ' * (2**(@level - i) / 2)
      end
    end
    if i < 5
      puts
      print str
      puts
    else
      puts 'Дерево обрезали'
      @level = 0
      @number = 0
      @hash.clear
      break
    end
    str.clear
  end
end

name = ENV['NAME']

if name
  a = File.open("/home/ilya/Documents/bsuir-courses/2017/
  IlyaStipakov/1/trees/#{name}.tree")
  content = a.read
  tree = JSON.parse(content)
  transform(tree)
  print_tree
  a.close
  tree.clear
else
  index = 0
  d = Dir.new('/home/ilya/Documents/bsuir-courses/2017/IlyaStipakov/1/trees/')
  d.entries.each do |e|
    next if e =~ /^\./
    file = File.join(d.path, e)
    @tree_array[index] = file
    index += 1
  end
  d.close
  @tree_array = @tree_array.sort
  @w = 0
  while @answer == true
    c = File.open("#{@tree_array[@w]}")
    @w += 1
    content = c.read
    tree = JSON.parse(content)
    transform(tree)
    print_tree
    @level = 0
    @number = 0
    @hash.clear
    print 'Желаете продолжить? [y/n]'
    break if gets.chomp == 'n'
    c.close
  end
end
