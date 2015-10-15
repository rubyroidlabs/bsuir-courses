LOGO1 = '     ++      +------ '
LOGO2 = '     ||      |+-+ |  '
LOGO3 = '   /---------|| | |  '
LOGO4 = '  + ========  +-+ |  '
LWHL11 = ' _|--O========O~\\-+  '
LWHL12 = '//// \\_/      \\_/    '
LWHL21 = ' _|--/O========O\\-+  '
LWHL22 = '//// \\_/      \\_/    '
LWHL31 = ' _|--/~O========O-+  '
LWHL32 = '//// \\_/      \\_/    '
LWHL41 = ' _|--/~\\------/~\\-+  '
LWHL42 = '//// \\_O========O    '
LWHL51 = ' _|--/~\\------/~\\-+  '
LWHL52 = '//// \\O========O/    '
LWHL61 = ' _|--/~\\------/~\\-+  '
LWHL62 = '//// O========O_/    '
train = [LOGO1, LOGO2, LOGO3, LOGO4, "", ""]
wheels = [[LWHL11, LWHL12], [LWHL21, LWHL22], \
[LWHL31, LWHL32], [LWHL41, LWHL42], [LWHL51, LWHL52], [LWHL61, LWHL62]]
n = 65
f = ""
l = LOGO1.length
i = n
empty = "#{' ' * n}"
# Path from right wall to left
while i != 0
  k = (i + n) / 3 % 6
  train[4] = wheels[k][0]
  train[5] = wheels[k][1]
  for j in 0..5
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
  for j in 0..5
    f = f + train[j][i..l] + empty[l - i..n] + "\n"
  end
  $> << "\e[2J\e[f" + f
  f.clear
  i += 1
  sleep 0.05
end
