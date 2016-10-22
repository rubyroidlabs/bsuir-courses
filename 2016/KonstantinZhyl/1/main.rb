#!/usr/bin/env ruby

def sum(x, y)
  x + y
end

def sub(x, y)
  x - y
end

def mult(x, y)
  x * y
end

def divis(x, y)
  x / y
end

def oper(x, y)
  x, y = x.to_i, y = y.to_i
  i, k = 1, 0
  while (k < y) && (x != 0)
    if x & i == i
      x -= i
      k += 1
    end
    i *= 2
  end
  x
end

array = []
top = 0

loop do
  newstr = gets.chomp
  if (newstr != "+") && (newstr != "-") && (newstr != "*") && (newstr != "/") && (newstr != "!")
    array[top] = newstr.to_f
    top += 1
    next
  else
    if newstr == "+"
      array[top - 2] = sum(array[top - 1], array[top - 2])
      top -= 1
    end
    if newstr == "-"
      array[top - 2] = sub(array[top - 2], array[top - 1])
      top -= 1
    end
    if newstr == "*"
      array[top - 2] = mult(array[top - 1], array[top - 2])
      top -= 1
    end
    if newstr == "/"
      array[top - 2] = divis(array[top - 2], array[top - 1])
      top -= 1
    end
    if newstr == "!"
      array[top - 2] = oper(array[top - 2], array[top - 1])
      top -= 1
    end
  end
  if top == 1
    puts array[0].to_s
    break
  end
end
