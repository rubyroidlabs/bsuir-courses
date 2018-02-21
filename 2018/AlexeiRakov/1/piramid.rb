def triangle(n, z, c, q)
  (0..n).map do |r|
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
    puts "#{left.center(135).green} #{num.rjust(8)}"
    puts "#{mas.ljust(5).red}"
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
