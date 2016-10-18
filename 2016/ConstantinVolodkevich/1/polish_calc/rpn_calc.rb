require './parser'

class RPN_calc

  def calc(task)
    parser = Parser.new

    elements = parser.clean_string(task)
    if elements.is_a? String
      "Kurwa! Seems that's not proper polish notation. Try again !"
    else
    stack = []
    elements.each do |e|

      if !(%w[* - + / ** ! .].include?(e))
        stack.push e.to_f
        next
      end

     if stack.size >= 2 && (%w[* - + / ** !].include?(e))
        b = stack.pop
        a = stack.pop

       case e
         when "*"
           stack.push a * b
         when "-"
           stack.push a - b
         when "+"
           stack.push a + b
         when "/"
           stack.push a / b
         when "**"
           stack.push a ** b
         when "!"
           stack.push toniller(a, b)
         else
       end

     else
       "Kurwa! Seems that's not proper polish notation. Try again !"
     end
    end

    stack.pop
    end
end

  def toniller(num, counter)
    counter = counter.round
    binary = "%b" % num
    binary.split("").reverse!.map!{|e| e =="1" && counter !=0 ? (counter -=1;e="0") : e }.reverse!.join.to_i(base=2)
  end
end






