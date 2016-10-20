$example = gets.chomp

array = []
stack = []

$example.gsub(/[\+\*\/\-]|\d+\.?\d*/) { |register| array << register }

def operation(operation, num1, num2)
  case (operation)
  when "+" then
    return num1 + num2
  when "*" then
    return num1 * num2
  when "/" then
    return num1 / num2
  when "-" then
    return num1 - num2
  end
end

array.each do |element|
  if /\d+\.?\d*/ === element
    stack << element.to_i
  elsif /[\+\*\/\-]/ === element
    num1 = stack.pop
    num2 = stack.pop
    stack << operation(element, num2, num1)
  end
end

puts "Result: #{stack.pop}"
