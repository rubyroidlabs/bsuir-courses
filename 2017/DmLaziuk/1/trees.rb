#!/usr/bin/env ruby
require 'zip'
require 'json'

@n = 0

@hash = Hash.new([0, 0])

@x = Array.new(10) { 0 }

def parse(arr, lvl = 0)
  @n = lvl > @n ? lvl : @n
  left = arr[0]
  right = arr[1]

  if left.is_a?(Integer) && right.is_a?(Array)
    @hash[[lvl, @x[lvl]]] = left
    @x[lvl] += 1
    parse(right, lvl + 1)
  elsif left.is_a?(Array) && right.is_a?(Array)
    parse(left, lvl)
    parse(right, lvl)
  else
    @hash[[lvl, @x[lvl]]] = left
    @x[lvl] += 1
    @hash[[lvl, @x[lvl]]] = right
    @x[lvl] += 1
  end
end

name = ENV['NAME']

if name
  Zip::File.open('trees.zip') do |zip_file|
    if zip_file.find_entry("trees/#{name}.tree")
      content = zip_file.read("trees/#{name}.tree")
      tree = JSON.parse(content)
      parse(tree)

      str = []
      (0..2 * @n).each { |i| str[i] = ' ' * (4 * 2**@n) }
      (0...@n).each do |y|
        (0...2**y).each do |x|
          str[2 * y + 1][2**(@n + 1 - y) + x * 2**(@n + 2 - y) + 1, 2] = '/\\'
        end
      end
      @hash.each do |yx, value|
        str[yx[0] * 2][2**(@n + 1 - yx[0]) + yx[1] * 2**(@n + 2 - yx[0]), 4]\
          = format('%3d ', value)
      end
      str.each { |s| puts s }
    else
      puts 'Данное дерево не растет в данном лесу.'
    end
  end
else
  puts 'Безымянных деревьев у нас не растет.'
end
