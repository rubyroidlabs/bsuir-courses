def triangle(n, z, c)
  (0..n).map do |r|
    n = [0]
    num = [c]
    left = [z]
    right = z
    c = 1
    k = 1
    (0..r - 1).step(1) do
      right = right * (r - k + 1) / k
      left.push right
      c += 1
      k += 1
    end
    num.to_s
    left.to_s
    puts "#{n.center(130).green} #{m.rjust(13)}"
  end
end
print 'enter the vertex of the triangle:'
z = gets.to_i
print 'enter the depth of the triangle:'
n = gets.to_i
puts "vertex triangle = #{z}"
puts "depth triangle = #{n}"
require 'colorize'
triangle(n, z, c)
