def triangle(n, z, c, q)
  (0..n).map do |r|
    k = [0]
    y = [0]
    h = [0]
    u = []
    mas = []
    n = [0]
    num = [c]
    left = [z]
    right = z
    c = 1
    k = 1
    (0..r - 1).step(1) do
      o = right
      right = right * (r - k + 1) / k
      u = right
      if o + u == q
        mas.push o
        mas.push right
      end
      left.push right 
      c += 1
      k += 1
    end
    h = left.to_s
    y = num.to_s
    k = mas.to_s
    puts "#{h.center(140).green} #{y.rjust(3)}"
    puts "#{k.ljust(10).red}"
  end
end
print 'enter the vertex of the triangle:'
z = gets.to_i
print 'enter the depth of the triangle:'
n = gets.to_i
print 'enter a child:'
q = gets.to_i
puts "vertex triangle = #{z}"
puts "depth triangle = #{n}"
puts 'parents will be selected from the left'
c = 0
require 'colorize'
triangle(n, z, c, q)
