#!/usr/bin/env ruby
require 'zip'
require 'json'

# @n -- глубина дерева
@n = 0

# hash -- хэш-таблица {[y, x] => элемент}
#         y -- позиция вглубь дерева
#         x -- позиция по оси x
@hash = Hash.new([0, 0])

# x[y] = текущая позиция x для каждого уровня y
#        10 -- максимальная глубина дерева
@x = Array.new(10) { 0 }

#
# pasre -- проход по всем узлам массива arr
#          и формирование
#          хэш-таблицы { [y,x] => значение }
#               y -- позиция вглубь дерева
#               x -- позиция по оси x
#
#          lvl -- текущая глубина
#
def parse(arr, lvl = 0)
  @n = lvl > @n ? lvl : @n
  left = arr[0]
  right = arr[1]

  if left.is_a?(Integer) && right.is_a?(Array)
    # узел [Integer, Array]
    @hash[[lvl, @x[lvl]]] = left
    @x[lvl] += 1
    parse(right, lvl + 1)
  elsif left.is_a?(Array) && right.is_a?(Array)
    # узел [Array, Array]
    parse(left, lvl)
    parse(right, lvl)
  else
    # узел [Integer, Integer]
    @hash[[lvl, @x[lvl]]] = left
    @x[lvl] += 1
    @hash[[lvl, @x[lvl]]] = right
    @x[lvl] += 1
  end
end

#
# print -- выводит на экран дерево
#

def print
  # str -- массив строк для вывода на экран
  #        размером 2*n, длина каждой строки 4*2^n
  str = []
  # инициализация пробелами
  (0..2 * @n).each { |i| str[i] = ' ' * (4 * 2**@n) }
  # расстановка веток
  (0...@n).each do |y|
    (0...2**y).each do |x|
      str[2 * y + 1][2**(@n + 1 - y) + x * 2**(@n + 2 - y) + 1, 2] = '/\\'
    end
  end
  # расстановка узлов
  @hash.each do |key, value|
    str[key[0] * 2][2**(@n + 1 - key[0]) + key[1] * 2**(@n + 2 - key[0]), 4] = \
      format('%3d ', value)
  end
  # печать
  str.each { |s| puts s }
end

# переменная окружения NAME
name = ENV['NAME']

if name
  Zip::File.open('trees.zip') do |zip_file|
    if zip_file.find_entry("trees/#{name}.tree")
      tree = JSON.parse(zip_file.read("trees/#{name}.tree"))
      parse(tree)
      print
    else
      puts 'Данное дерево не растет в данном лесу.'
    end
  end
else
  Zip::File.open('trees.zip') do |zip_file|
    zip_file.glob('trees/*.tree').sort_by(&:name).each do |entry|
      tree = JSON.parse(entry.get_input_stream.read)
      # для каждого цикла приходится обнулять n, hash, x
      @n = 0
      @hash = Hash.new([0, 0])
      @x = Array.new(10) { 0 }
      parse(tree)
      puts entry.name
      print
      puts 'Желаете продолжить? [y/n]'
      q = gets
      break if q[0, 1] == 'n'
    end
    puts 'Спасибо что были в нашем лесу'
  end
end
