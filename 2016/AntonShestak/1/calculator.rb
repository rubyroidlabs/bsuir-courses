def digit?(str)
  a = str.match(/-?\d+(\.\d+)?/)
  a.to_s.length == str.length
end

def operator?(str)
  "+-*/!".include?(str)
end

def to_zero(a, b)
  bin = a.to_i.to_s(2)
  b.to_i.times { bin[bin.rindex("1")] = "0" }
  bin.to_i(2).to_s
end

def rpn
  digit_cnt = operator_cnt = 0
  stack = []
  error_flag = false
  puts "Let's start:"
  while (operator_cnt == 0 || digit_cnt - operator_cnt != 1)
    input = gets.chomp()
    if input == ""
      error_flag = true
    end
    if digit?(input) && !error_flag
      stack.push(input)
      digit_cnt += 1
    elsif operator?(input) && !error_flag
      if stack.length <= 1
        puts "It's not normal calculator! It's polish! Try again!"
      else
        operator_cnt += 1
        second = stack.pop
        first = stack.pop
        if input == "/"
          stack.push(eval(first.to_f.to_s + input + second).to_s)
        elsif input == "!"
          stack.push(to_zero(first, second))
        else
          stack.push(eval(first + input + second).to_s)
        end
      end
    else
      puts "Something went wrong. Try again"
      error_flag = false
    end 
  end
  puts "Your answer is:"
  puts "-- " + stack.pop.to_s
end

rpn
