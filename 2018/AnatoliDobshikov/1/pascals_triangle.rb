# Program draws pascal's triangle with the specified depth in the console
# values input
print 'Input tree depth: '
tree_depth = gets.chomp.to_i
print 'Input base number: '
base_number = gets.chomp.to_i
# checking values
if tree_depth <= 0 || base_number <= 0
  puts 'Invalid value. Try to type positive integer.'
  exit
end
# tree create
NUM_LENGTH = 4 # the maximal length in the triangle
coef = [base_number]
console_cols = `/usr/bin/tput cols`.chomp.to_i - 4 # fix trailing blank line
spaces = ' ' * (tree_depth / NUM_LENGTH > 0 ? tree_depth / NUM_LENGTH : 1)
tree_depth.times do |level|
  printf('%03d:', level)
  puts coef.join(spaces).center(console_cols)
  coef.push(0)
  (level + 1).downto(1) do |column|
    coef[column] += coef[column - 1]
  end
end
