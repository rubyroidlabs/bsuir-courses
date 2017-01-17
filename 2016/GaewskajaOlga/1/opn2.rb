puts 'Значения: '
mas = []
a = 'f'
m = m.to_i #last
n = n.to_i #last but one
t = t.to_i
while a.empty? == false
  a = gets.chomp
  a = a.to_s
  case a
  #when a!= '+' and a!='-' and a!='*' and a!='/'

  when '+'
    n, m = mas.pop, mas.pop
    t = n + m
    mas.push t
  when '-'
    n, m = mas.pop, mas.pop
    mas.push m - n
  when '*'
    n, m = mas.pop, mas.pop
    mas.push n*m
  when '/'
    n, m = mas.pop, mas.pop
    mas.push m/n
  when '!'
    n, m = mas.pop, mas.pop
    m = m.to_s(2)
    razm = m.length
    while n!=0
      if m[razm - 1]!='0'
        m[razm - 1] = '0'
        n = n - 1
      end
      razm = razm - 1
    end
    base = 2
    decimalNumber = 0
    array = m.reverse.split("") # Для преобразования, с помощью команды reverse, разворачиваем число задом наперед. И, с помощью команды split(""), пеобразовываем строку в массив и разбиваем строку на части.
    array.each_with_index { |elem, index| decimalNumber += elem.to_i * base ** index }
    mas.push decimalNumber
  else mas.push a.to_i

end

end
p mas[0] 
