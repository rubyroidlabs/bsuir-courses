class PascalsTriangle
  def initialize
    print "Enter the depth of the triangle:\n n="
    @rows = gets.chomp.to_i
  end

  def to_pascal
    temp = []
    @rows.times do |row|
    line = [1]
    (0..row-1).each { |x| line << (line[x] * (row - x) / (x + 1)) }
    temp << line
  end
  end
  temp
end

  def print_triangle
    max = to_pascal.flatten.max.to_s.length
    strings = to_pascal.map { |arr| arr.map { |int| int.to_s.center(max + 3)} }
    strings.each do |line|
    puts line.join.center(strings[-1].join.length)
  end
end

row = PascalsTriangle.new
row.print_triangle
