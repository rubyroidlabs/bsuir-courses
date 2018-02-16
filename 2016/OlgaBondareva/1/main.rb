def show(numbers, num_count, signs, sig_count, direction, level)
  if num_count == numbers.size
    exit
  elsif signs[sig_count] == '['
    print_number_left(numbers, num_count, direction, level)
    show(numbers, num_count + 1, signs, sig_count + 1, 'r', level - 1)
  elsif signs[sig_count] == ','
    print_number_right(numbers, num_count, direction, level)
    show(numbers, num_count + 1, signs, sig_count + 1, 'l', level)
  elsif signs[sig_count] == ']'
    print_number_left(numbers, num_count, direction, level)
    show(numbers, num_count + 1, signs, sig_count + 1, 'r', level)
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
  f = File.new(ARGV[0])
  content = f.read
  f.close
  content.chop!
  numbers = Marshal.load(Marshal.dump(content))
  signs = Marshal.load(Marshal.dump(content))
  numbers.delete!(']').delete!('[')
  numbers = numbers.split(/[,]/)
  0.upto(9) do |i|
    signs.delete!(i.to_s)
  end
  show(numbers, 0, signs, 0, 'l', numbers.size)
end

main
