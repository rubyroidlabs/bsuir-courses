def pascal(n)
  print 'Введите базовый номер: '
  f = gets.chomp.to_i
  h = f
    (0..n).each { |r|
      tree = [h]
      base = f
      k = 1
        (0..r - 1).step(1) { |index|
        base = base * ( r - k + 1 ) / k
        tree.push base
      k += 1}
    p tree}
end
print 'Введите глубину дерева: '
n = gets.chomp.to_i
pascal(n)
