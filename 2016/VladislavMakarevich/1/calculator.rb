$example = gets.chomp

array = []
stack = []

$example.gsub(/[\+\*\/\-]|\d+\.?\d*/) { |register| array << register }

def operation(operation, num1, num2)
  case(operation)
    when '+' then
      return num1 + num2
    when '*' then
      return num1 * num2
    when '/' then
      return num1 / num2 
    when '-' then
      return num1 - num2
  end
end

array.each do |element|
  # puts '# {stack} writeStack'
  # puts '# {element}'
  # puts '1. # {/\d+\.?\d*/ === element}'
  # puts '2. # {/[\+\*\/\-]/ === element}'

  if /\d+\.?\d*/ === element
    # puts 'element.to_i = # {element.to_i}'
    stack << element.to_i
    # puts "stack: # {stack}"
  elsif /[\+\*\/\-]/ === element
    a = stack.pop
    b = stack.pop
    stack << operation(element,b,a)
  end
end

puts 'Result: # {stack.pop}'
