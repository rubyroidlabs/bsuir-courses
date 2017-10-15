def show(numbers, num_count, signs, sig_count, direction, level)
  if num_count == numbers.size
    exit
  elsif signs[sig_count] == '['
    print_number_left(numbers, num_count, direction, level)
    show(numbers, num_count += 1, signs, sig_count += 1, 'r', level -= 1)
  elsif signs[sig_count] == ','
    print_number_right(numbers, num_count, direction, level)
    show(numbers, num_count += 1, signs, sig_count += 1, 'l', level)
  elsif signs[sig_count] == ']'
    print_number_left(numbers, num_count, direction, level)
    show(numbers, num_count += 1, signs, sig_count += 1, 'r', level)
  end
end

def print_number_left(numbers, num_count, direction, level)
  print ' ' * level #
  print numbers[num_count]
  print "\n"
  output(level, direction)
end

def print_number_right(numbers, num_count, direction, level)
  print ' ' * level #
  print numbers[num_count]
  print "\n"
  output(level, direction)
end

# some piece of output
def output(level, direction)
  print ' ' * (level - 1) #
  if direction.eql?('l')
    print '/'
    print "\n"
  elsif direction.eql?('r')
    print '\\'
    print "\n"
  end
end

# entry point for program
def main
  # if ARGV.length != 1
  # puts "We need exactly one parameter. The name of a tree.\n"
  # exit
  # end

  # filename = ARGV[0]
  f = File.new('trees/alica.tree')
  content = f.read
  f.close

  content.chop!
  numbers = Marshal.load(Marshal.dump(content))
  signs = Marshal.load(Marshal.dump(content))
  numbers.delete!(']')
  numbers.delete!('[')
  numbers = numbers.split(/[,]/)
  signs.delete!('0')
  signs.delete!('1')
  signs.delete!('2')
  signs.delete!('3')
  signs.delete!('4')
  signs.delete!('5')
  signs.delete!('6')
  signs.delete!('7')
  signs.delete!('8')
  signs.delete!('9')
  level = numbers.size
  show(numbers, 0, signs, 0, 'l', level)
end

main
