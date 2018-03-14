print 'Enter depth: '
depth = gets.to_i
print 'Enter basic number: '
base_number = gets.to_i
array = []
(1..depth).each do |i|
  array[i] = 0
end
z = depth
array[0] = base_number
(1..depth).each do |j|
  (1..j).reverse_each do |i|
    if(i==j)
      x = " "*z
      end
    print "#{x}#{array[i - 1]} "
    array[i] = array[i - 1] + array[i]
      end
  z-=1
  puts
end
