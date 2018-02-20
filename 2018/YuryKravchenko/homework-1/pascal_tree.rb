# My Homework

def pascal(n)

  (0..n).each{|r|
    tree=[1]
    term=1
    k=1
    (0..r-1).step(1){|index|
      term=term*(r-k+1)/k
      tree.push term
      k+=1}
    p tree}
end
print "Введите глубину дерева: "
n = gets.to_i
pascal(n)
