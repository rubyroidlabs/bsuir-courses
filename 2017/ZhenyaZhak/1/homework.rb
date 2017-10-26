require 'json'
# D_I - default indentation
MAX_LEVEL = 6
D_I = 2

def steep(value)
  (0...value).each do
    print ' '
  end
end

def decision(kol, level)
  # 5000 maximum permissible weight of the tree
  if kol > 5000
    puts 'Дерево нужно срубить'
  else
    puts 'Дерево можно Оставить'
  end
  if level > MAX_LEVEL
    puts 'Дерево обрезано'
  else
    puts 'Дерево целое'
  end
end

def slesh(kol, space)
  steep(D_I**space - D_I)
  (0...kol).each do |i|
    (i % D_I).zero? ? (printf ' /') : (printf '\ ')
    steep(D_I**(space + 1) - D_I)
  end
  puts ' '
end

def rendering(vec, vrem)
  max_level = vrem
  flag = 0
  steep(D_I**vrem - D_I)
  vec.each do |veci|
    if veci.nil?
      puts ' '
      vrem -= 1
      if vrem.zero?
        break
      end
      slesh(D_I**(max_level - vrem), vrem)
      steep(D_I**vrem - D_I)
      flag = 0
    else
      flag == 1 ? steep(D_I**(vrem + 1) - D_I) : flag = 1
      # since numbers less than 10 require a space
      if veci < 10
        print ' '
      end
      print veci
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
    array << JSON.parse(tree_string)
    loop do
      if array.empty?
        break
      end
      # 0 and 1 is the left and right child
      array.each do |ari|
        (0..1).each do |i|
          if ari[i].is_a? Integer
            vec << ari[i]
          else
            array_temp << ari[i]
          end
        end
      end
      array = array_temp
      array_temp = Array.new
      if vec[vec.length - 1].nil?
        next
      else
        vec << nil
      end
    end
    kol = 0
    level = 0
    vec.each do |veci|
      veci.nil? ? level += 1 : kol += veci
    end
    level > MAX_LEVEL ? rendering(vec, MAX_LEVEL) : rendering(vec, level)
    decision(kol, level)
  end
end

if ENV['NAME'].nil?
  list = Dir.entries('/home/zhenya/bsuir-courses/2017/ZhenyaZhak/1/trees/')
  list.delete_if { |value| !value.include?('.tree') }
  list.sort!
  list.each do |listi|
    puts "\n#{listi}"
    Tree.draw(listi)
    print 'Do it! [y/n]'
    per = gets
    if per.include?('n')
      break
    end
  end
else
  Tree.draw(ENV['NAME'] + '.tree')
end
