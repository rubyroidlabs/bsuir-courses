LOGO1 = '     ++      +------ '
LOGO2 = '     ||      |+-+ |  '
LOGO3 = '   /---------|| | |  '
LOGO4 = '  + ========  +-+ |  '
L11 = ' _|--O========O~\\-+  '
L12 = '//// \\_/      \\_/    '
L21 = ' _|--/O========O\\-+  '
L22 = '//// \\_/      \\_/    '
L31 = ' _|--/~O========O-+  '
L32 = '//// \\_/      \\_/    '
L41 = ' _|--/~\\------/~\\-+  '
L42 = '//// \\_O========O    '
L51 = ' _|--/~\\------/~\\-+  '
L52 = '//// \\O========O/    '
L61 = ' _|--/~\\------/~\\-+  '
L62 = '//// O========O_/    '
train = [LOGO1, LOGO2, LOGO3, LOGO4]
wheels = [[L11, L12], [L21, L22], [L31, L32], [L41, L42], [L51, L52], [L61, L62]]
n = 65
f = ""
l = LOGO1.length
i = n
empty = "#{' ' * n}"
ary = [0,1,2,3,4,5]
# Path from right wall to left
while i != 0
  k = (i + n) / 3 % 6
  train << wheels[k][0]
  train << wheels[k][1]
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
  train << wheels[k][0]
  train << wheels[k][1]
  ary.each do |j|
    f = f + train[j][i..l] + empty[l - i..n] + "\n"
  end
  $> << "\e[2J\e[f" + f
  f.clear
  i += 1
  sleep 0.05
end
