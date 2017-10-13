require 'json'

def steep(value)
  (0...value).each do
    print ' '
  end
end

def decision(kol, level)
  if kol > 5000
    puts 'Срубить'
  else
    puts 'Оставить'
  end
  if level > 6
    puts 'Дерево обрезанно'
  else
    puts 'Дерево целое'
  end
end

def slesh(kol, space)
  steep(2**space - 2)
  (0...kol).each do |i|
    (i % 2).zero? ? ( printf ' /' ) : ( printf '\ ' )
    steep(2**(space + 1) - 2)
  end
  puts ' '
end

def rendering(vec, vrem)
  max_level = vrem
  flag = 0
  steep(2**vrem - 2)
  vec.length.times do |i|
    if vec[i].nil?
      puts ' '
      vrem -= 1
      if vrem.zero?
        break
      end
      slesh(2**(max_level - vrem), vrem)
      steep(2**vrem - 2)
      flag = 0
    else
      flag == 1 ? steep(2**(vrem + 1) - 2) : flag = 1
      if vec[i] < 10
        print ' '
      end
      print vec[i]
    end
  end
end

class Tree
  def self.draw(name)
    vec = Array.new
    array = Array.new
    array_temp = Array.new
    file_name = '/home/zhenya/bsuir-courses/2017/ZhenyaZhak/1/trees/' + name
    tree_string = File.read(file_name)
    tree_inf = JSON.parse(tree_string)
    array << tree_inf
    while !array.first.nil?
      array.length.times do |i|
        if array[i][0].is_a? Integer
          vec << array[i][0]
        else
          array_temp << array[i][0]
        end
        if array[i][1].is_a? Integer
          vec << array[i][1]
        else
          array_temp << array[i][1]
        end
      end
      array = Array.new
      array += array_temp
      array_temp = Array.new
      if vec[vec.length - 1].nil?
        next
      else
        vec << nil
      end
    end
    kol = 0
    level = 0
    vec.length.times do |i|
      vec[i].nil? ? level += 1 : kol += vec[i]
    end
    level > 6 ? rendering(vec, 6) : rendering(vec, level)
    decision(kol, level)
  end
end

if ENV['NAME'].nil?
  list = Dir.entries('/home/zhenya/bsuir-courses/2017/ZhenyaZhak/1/trees/')
  list.delete_if { |value| !value.include?('.tree') }
  list.sort!
  list.length.times do |i|
    puts '\n' + list[i].to_s
    Tree.draw(list[i])
    print 'Do it! [y/n]'
    per = gets
    if per.include?('n')
      break
    end
  end
else
  Tree.draw(ENV['NAME'] + '.tree')
end
