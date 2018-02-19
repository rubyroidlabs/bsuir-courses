class PrintPascalTriangle
def initialize
print "Enter the depth of the triangle n = "
@rows = gets.chomp.to_i 
end
def calculatedRow
triangle = []
@rows.times do |row|
line = [1]
(0..row-1).each {|x| line << (line[x] * (row-x) / (x+1)) }
triangle << line
end
triangle
end
def printTriangle
max = calculatedRow.flatten.max.to_s.length
strings = calculatedRow.map {|arr| arr.map {|int| int.to_s.center(max + 3)} }
strings.each do |line|
puts line.join.center(strings[-1].join.length)
end
end
row = PrintPascalTriangle.new
row.printTriangle