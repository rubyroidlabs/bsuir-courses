print "Enter depth: "
depth = gets.to_i
print "Enter basic number: "
base_number = gets.to_i
array = []
for i in 1..depth
  array[i] = 0
end
array[0] = base_number
for j in 1..depth
  (1..j).reverse_each do |i|
    print "#{array[i - 1]} "
    array[i] = array[i - 1] + array[i]
  end
  puts
end
