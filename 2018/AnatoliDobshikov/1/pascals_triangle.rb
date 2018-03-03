<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 987cd1c... changed the names of variables
# Program draws pascal's triangle with the specified depth in the console
# values input
print 'Input tree depth: '
tree_depth = gets.chomp.to_i
print 'Input base number: '
base_number = gets.chomp.to_i
# checking values
if tree_depth <= 0 || base_number <= 0
  puts 'Invalid value. Try to type positive integer.'
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 987cd1c... changed the names of variables
  exit
end
# tree create
NUM_LENGTH = 4 # the maximal length in the triangle
coef = [base_number]
<<<<<<< HEAD
<<<<<<< HEAD
cols = `/usr/bin/tput cols`.chomp.to_i
<<<<<<< HEAD
<<<<<<< HEAD
spaces = ' ' * (tree_depth / FOUR > 0 ? tree_depth / 4 : 1)
=======
spaces = ' ' * (tree_depth / FOUR > 0 ? tree_depth / FOUR : 1)
>>>>>>> 987cd1c... changed the names of variables
=======
=======
console_cols = `/usr/bin/tput cols`.chomp.to_i
>>>>>>> a882e80... Pascals triangle with fix(i)es
spaces = ' ' * (tree_depth / NUM_LENGTH > 0 ? tree_depth / NUM_LENGTH : 1)
>>>>>>> 9ebe98e... New understanging of the names of the variables!
(0...tree_depth).each do |level|
=======
console_cols = `/usr/bin/tput cols`.chomp.to_i - 4 # fix trailing blank line
spaces = ' ' * (tree_depth / NUM_LENGTH > 0 ? tree_depth / NUM_LENGTH : 1)
tree_depth.times do |level|
>>>>>>> 74ee23b... Pascals triangle with fix(i)es
  printf('%03d:', level)
  puts coef.join(spaces).center(console_cols)
  coef.push(0)
  (level + 1).downto(1) do |column|
    coef[column] += coef[column - 1]
  end
end
<<<<<<< HEAD

<<<<<<< HEAD
=======
#Program draws pascal's triangle with the specified depth in the console
#values input
print "Input tree depth: ";
=======
# Program draws pascal's triangle with the specified depth in the console
# values input
print 'Input tree depth: '
>>>>>>> d239144... fix styling issues
tree_depth = gets.chomp.to_i
print 'Input base number: '
base_number = gets.chomp.to_i
# checking values
if tree_depth <= 0 || base_number <= 0
  puts 'Invalid value. Try to type integer.'
=======
>>>>>>> 42628a3... some optimization
  exit
end
# tree create
coef = [base_number]
cols = `/usr/bin/tput cols`.chomp.to_i
spaces = ' ' * (tree_depth / 4 > 0 ? tree_depth / 4 : 1)
0.upto(tree_depth - 1) do |i|
  printf('%03d:', i)
  puts coef.join(spaces).center(cols)
  coef.push(0)
  (i + 1).downto(1) do |j|
    coef[j] += coef[j - 1]
  end
end
>>>>>>> 19cbc15... homework 1
=======
>>>>>>> 987cd1c... changed the names of variables
=======
>>>>>>> f1acbcc... deleted trailing blank line
