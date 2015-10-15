ascii = []
s1 = "___________                        _________"
s2 = "                      __  .__    .__                 "
ascii << s1 + s2
s1 = '\__    ___/__.__.______   ____    /   _____/'
s2 = ' ____   _____   _____/  |_|  |__ |__| ____    ____   '
ascii << s1 + s2
s1 = '  |    | <   |  |\____ \_/ __ \   \_____  \ '
s2 = '/  _ \ /     \_/ __ \   __\  |  \|  |/    \  / ___\  '
ascii << s1 + s2
s1 = '  |    |  \___  ||  |_> )  ___/   /        ('
s2 = '  <_> )  Y Y  \  ___/|  | |   Y  \  |   |  \/ /_/  > '
ascii << s1 + s2
s1 = '  |____|  / ____||   __/ \___  > /_______  /'
s2 = '\____/|__|_|  /\___  >__| |___|  /__|___|  /\___  /  '
ascii << s1 + s2
s1 = '          \/     |__|        \/          \/ '
s2 = '            \/     \/          \/        \//_____/   '
ascii << s1 + s2

strlen = ascii[0].length - 1
strlen.downto(0) do |seenlen|
  system 'clear'
  0.upto(5) do |strnum|
    seenlen.upto(strlen) do |symbol|
      print ascii[strnum][symbol]
    end
    puts ' '
  end
  sleep(1.0 / 20.0)
end

1.upto(40) do |distance|
  system 'clear'
  0.upto(5) do |strnum|
    0.upto(distance) do
      print ' '
    end
    puts ascii[strnum]
  end
  sleep(1.0 / 20.0)
end
