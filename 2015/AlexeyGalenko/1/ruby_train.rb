LOGO1 = '     ++      +------ '
LOGO2 = '     ||      |+-+ |  '
LOGO3 = '   /---------|| | |  '
LOGO4 = '  + ========  +-+ |  '
L1 = ' _|--O========O~\\-+  '
L2 = '//// \\_/      \\_/    '
L3 = ' _|--/O========O\\-+  '
L4 = '//// \\_/      \\_/    '
L5 = ' _|--/~O========O-+  '
L6 = '//// \\_/      \\_/    '
L7 = ' _|--/~\\------/~\\-+  '
L8 = '//// \\_O========O    '
L9 = ' _|--/~\\------/~\\-+  '
L10 = '//// \\O========O/    '
L11 = ' _|--/~\\------/~\\-+  '
L12 = '//// O========O_/    '
train = [LOGO1, LOGO2, LOGO3, LOGO4, '', '']
wheels = [[L1, L2], [L3, L4], [L5, L6], [L7, L8], [L9, L10], [L11, L12]]
n = 65
f = ""
l = LOGO1.length
i = n
empty = "#{' ' * n}"
ary = [0, 1, 2, 3, 4, 5]
# Path from right wall to left
while i != 0
  k = (i + n) / 3 % 6
  train[4] = wheels[k][0]
  train[5] = wheels[k][1]
  ary.each do |j|
    sub = n - i
    if sub <= l
      f = f + empty[0..i] + train[j][0..sub] + "\n"
    else
      f = f + empty[0..i] + train[j] + empty[i + l..n] + "\n"
    end
  end
  $> << "\e[2J\e[f" + f
  f.clear
  i -= 1
  sleep 0.05
end
# Path through left wall
i = 0
while i != l
  k = i / 3 % 6
  train[4] = wheels[k][0]
  train[5] = wheels[k][1]
  ary.each do |j|
    f = f + train[j][i..l] + empty[l - i..n] + "\n"
  end
  $> << "\e[2J\e[f" + f
  f.clear
  i += 1
  sleep 0.05
end
