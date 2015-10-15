cols = `tput cols`.to_i
shift_t = 2
car = [
  '   *****  '.split(''), '   *   *  '.split(''), '****   ***'.split(''),
  '*        *'.split(''), '**********'.split(''), '  **   ** '.split('')
]
cols.downto(-car.max.size)  do  |shift|
  background = Array.new(10) { Array.new(cols) { ' ' } }
  0.upto(car.size - 1)  do  |i|
    0.upto(car.max.size - 1)  do  |j|
      if  shift + j < cols && shift + j >= 0
        background[shift_t + i][shift + j] = car[i][j]
      end
    end
  end
  sleep 0.05
  print `clear`
  print background.join
end
print `clear`
