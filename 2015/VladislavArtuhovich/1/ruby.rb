# hash = {}
# hash = Hash.new
# hash = Hash.new {|key|
# 	puts key
# }


# hash[123] = 123

# hash = {a: 1, b: 2, c: 3}
# puts hash.key
# ####################3
# hash.each_pair do |key, value|
# 	puts "key = #{key}, value = #{value}"
# end
# #\\\\\\\\\\\\\
# arr = [1,2,3,4,5]

# arr.first // arr.last
# arr.firs(2) # 1,
# arr[-1] # 5
# arr.count #size of array, possible arr.size && arr.length
# arr.empty? 
# arr.select #arr.filter
# arr.push 6 
# arr.pop

# arr = [1,2,3,4,5,nil,nil, 6] #
# arr.compact.each {|id| puts id * 2} 

# arr.uniq
# arr.reverse
# arr.rotate(4)
# arr.shuffle
# arr[1..6]
# #########
# matrix.traspose
# matrix.flatten

# arr.each {|i| i*2}
# arr.map {|i| i*2}

# arr.select { |i| i.even? }
# arr.reject { |i| i.even? }

# arr.join(' and ') # arr * ' and '
# arr | [7]
# arr << 7(
# [1,2,3] == [1,2,3]

# #GEM GEMS

# arr.repeated_permutation(2).to_a
# #############



# require 'benchmark'

# array = [1..1000000].map {Math.rand(100000)}

# Benchmark.bmbm do |x|
# 	x.report("sort 1") {array.dup.sort}
# 	x.report("sort 1") {array.dup.sort}
# end

