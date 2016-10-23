#!/usr/bin/env ruby
@numbers = []
@operations = []

def num_to_bit(f_op, s_op)
  bits = []
  while f_op.positive?
    bits.push(f_op % 2)
    f_op /= 2
  end
  zero_bit(bits, s_op)
end

def zero_bit(bits, s_op)
  i = 0
  j = 0
  while i < s_op
    if bits[j].nonzero?
      bits[j] = 0
      i += 1
    end
    j += 1
  end
  bit_to_num(bits)
end

def bit_to_num(bits)
  i = 0
  r_op = 0
  while i < bits.size
    r_op += bits[i] * (2**i)
    i += 1
  end
  @numbers.push(r_op)
end

expression = gets.chomp

expression = expression.split(" ")
expression.map do |x|
  if /[0-9]/ =~ x
    @numbers.push(x.to_i)
  elsif %r{\+|\*|\/|\-|\!} =~ x
    @operations.push(x.to_sym)
  end
end

puts "Incorrect expression!" if @numbers.size != @operations.size + 1

@operations = @operations.reverse

while @numbers.size != 1
  s_op = @numbers.pop
  f_op = @numbers.pop

  case @operations.pop
  when /\+/ then @numbers.push(f_op + s_op)
  when /\-/ then @numbers.push(f_op - s_op)
  when /\*/ then @numbers.push(f_op * s_op)
  when %r{\/} then
    if s_op.zero?
      puts "Division by zero!"
      exit
    else
      @numbers.push(f_op.to_f / s_op.to_f)
    end
  when /\!/ then num_to_bit(f_op, s_op)
  end
end
puts "Result: " + @numbers.pop.to_s
