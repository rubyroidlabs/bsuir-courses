require 'json'

@treedepth = 0
@elements = Hash.new([0, 0])
@currentposition = Array.new(10) { 0 }

def parse(arr, lvl = 0)
  @treedepth = lvl > @treedepth ? lvl : @treedepth
  left = arr[0]
  right = arr[1]
  if left.is_a?(Integer) && right.is_a?(Array)
    @elements[[lvl, @currentposition[lvl]]] = left
    @currentposition[lvl] += 1
    parse(right, lvl + 1)
  elsif left.is_a?(Array) && right.is_a?(Array)
    parse(left, lvl)
    parse(right, lvl)
  else
    @elements[[lvl, @currentposition[lvl]]] = left
    @currentposition[lvl] += 1
    @elements[[lvl, @currentposition[lvl]]] = right
    @currentposition[lvl] += 1
  end
end

name = ENV['NAME']

def printtree
  str = []
  (0..2 * @treedepth).each do |i|
    str[i] = ' ' * (4 * 2**@treedepth)
  end
  (0...@treedepth).each do |y|
    (0...2**y).each do |x|
      a = 2**(@treedepth + 1 - y) + x * 2**(@treedepth + 2 - y) + 1
      str[2 * y + 1][a, 2] = '/\\'
    end
  end
  @elements.each do |key, value|
    a = 2**(@treedepth + 1 - key[0]) + key[1] * 2**(@treedepth + 2 - key[0])
    str[key[0] * 2] [a, 4] = '%3d '.to_s % value.to_s
  end
  str.each { |s| puts s }
end

if name
  name_file = "trees/#{ENV['NAME']}.tree"
  f = File.exist?(name_file)
  if f
    file = File.read(name_file)
    tree = JSON.parse(file)
    parse(tree)
    printtree
  else
    puts 'Данное дерево не растет в данном лесу.'
  end
else
  forest = []
  Dir.foreach('trees') do |filename|
    forest.push filename
  end
  forest.each do |n|
    puts n
    ff = File.read("trees/#{n}")
    tree = JSON.parse(ff)
    @treedepth = 0
    @elements = Hash.new([0, 0])
    @currentposition = Array.new(10) { 0 }
    parse(tree)
    printtree
    puts 'Желаете продолжить? [y/n]'
    answer = gets.chomp
    break if answer == 'n'
  end
  puts 'Спасибо, что были в нашем лесу'
end
