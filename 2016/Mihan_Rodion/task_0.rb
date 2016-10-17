  def operation!(count, number)
    str = number.to_s(2).reverse 
    str.length.times do |i| 
      break if arg1 <= 0
      if str[i] == '1'
        str[i] = '0'
        count -= 1
      end
    end
    str.reverse.to_i(2)
  end

  result = []
  item = ""
  stack = []
  puts "Enter '=' if you want to calculate your expression!"
  while item = gets.chomp 
    break if item.include? "="
    item =~ /[\d\+\*\/\!]/? result << item : puts("Incorrectly input!")
  end
  result.each do |element|
    stack.push case element 
      when /\d/
        element.to_i
      when /\+/
        stack.pop + stack.pop
      when /\-/
        stack.pop - stack.pop
      when /\*/
        stack.pop * stack.pop
      when /\//
        stack.pop / stack.pop
      when /\!/
        operation!(stack.pop,stack.pop)
    end
  end
  puts "Result: #{stack.pop}"
