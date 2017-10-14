require 'json'

@treedepth = 0
@elements = Hash.new([0, 0])
@currentposition = Array.new(100) { 0 }

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

if name
  name_file = "trees/#{ENV['NAME']}.tree"
  content = File.read(name_file)
  name_file.chars.each do |f|
    if content
      f = content
      tree = JSON.parse(f)
      parse(tree)
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
    else
      puts 'Данное дерево не растет в данном лесу.'
    end
  end
else
  puts 'Безымянных деревьев у нас не растет.'
end
