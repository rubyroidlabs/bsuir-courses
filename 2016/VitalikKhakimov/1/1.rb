require 'zip'
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

def printtree
  str = []    
      (0..2 * @treedepth).each { |i| str[i] = ' ' * (4 * 2**@treedepth) } 
      (0...@treedepth).each { |y| (0...2**y).each { |x| str[2 * y + 1][2**(@treedepth + 1 - y) + x * 2**(@treedepth + 2 - y) + 1, 2] = '/\\' } }
      @elements.each { |key, value| str[key[0] * 2][2**(@treedepth + 1 - key[0]) + key[1] * 2**(@treedepth + 2 - key[0]), 4] = '%3d ' % value }
      str.each { |s| puts s }
end
name = ENV['NAME']

  if name
  name_file = "trees/#{ENV['NAME']}.tree"
  content = File.read(name_file)
  name_file.chars.each do |f|
    if content
      f = content
      tree = JSON.parse(f)
      parse(tree)
      printtree
    else
      puts 'Данное дерево не растет в данном лесу.'
    end
  end
  else
  puts 'Безымянных деревьев у нас не растет.'
  end