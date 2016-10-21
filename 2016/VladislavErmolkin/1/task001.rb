NUM_REGEX = /[-+]?[0-9]*\.?[0-9]+(?:[eE][-+]?[0-9]+)*/
SIGN_REGEX = /[\+\-\*\/\!]{1}/
$example = "3 5 + 4 / 7 * 3 4 + -"


def main()
    begin
        stack = validate_str gets

        result = RPN(stack)
        
        result.to_i if result == result.to_i

         return "=> " + result.to_s

     rescue IOError => ex
         puts "#{ex.class}: #{ex.message}"
         exit
     rescue TypeError => ex
         puts "Error: Incorrect RPN."
         exit
     rescue NoMethodError => ex
         puts "Error: Incorrect RPN."
         exit
     end


end


def validate_str(str)
    elements = str.split
    elements.map! do |element| 
        if element.match(NUM_REGEX)
            element.to_f
        elsif element.match(SIGN_REGEX)
            element
        else
            raise IOError, "Input error."
        end
    end
    .reverse!


    return elements
end


def RPN (source)
    stack = []
    until source.empty? do
        if (el = source.pop).is_a? Float
            stack.push el
        else 
            op1, op2 = stack.pop, stack.pop
            case el
            when "+"
                stack.push (op1 + op2)
            when "-"
                stack.push (op2 - op1)
            when "*"
                stack.push (op1 * op2)
            when "/"
                stack.push (op2 / op1)
            when "!"
                stack.push zeroing(op2, op1)
            end
        end
    end
    raise TypeError if stack.length != 1
    return stack[0]
end

def zeroing(number, q)
    s = [number].pack("f").unpack("b*")[0]
    q.to_i.times { s.sub!("1", "0") }
    return [s].pack("b*").unpack("f")[0]
end

puts main