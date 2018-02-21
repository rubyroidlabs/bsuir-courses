#!/usr/bin/env ruby

def pas_tri(h, n)
  l = [n]
  [l] + (1..h).map do
    l = [n] + l[1..-1].map.with_index { |x, i| x + l[i] } + [n]
  end
end

def pad(s, n)
  l = n - s.size
  ' ' * (l / 2) + s + ' ' * (l - l / 2)
end

def lines(rows)
  n = "#{rows[-1].max}".size
  rows.map do |row|
    row.map { |x| pad("#{x}", n) }.join(' ')
  end
end

def center(l)
  n = l[-1].size
  l.map { |s| pad(s, n) }
end

puts 'Введите глубину дерева: '
h = gets.chomp.to_i
puts 'Введите базовый номер: '
n = gets.chomp.to_i
puts center lines pas_tri(h, n)
