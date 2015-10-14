ascii = []
ascii << "___________                        _________                      __  .__    .__                 "
ascii << '\__    ___/__.__.______   ____    /   _____/ ____   _____   _____/  |_|  |__ |__| ____    ____   '
ascii << '  |    | <   |  |\____ \_/ __ \   \_____  \ /  _ \ /     \_/ __ \   __\  |  \|  |/    \  / ___\  '
ascii << '  |    |  \___  ||  |_> )  ___/   /        (  <_> )  Y Y  \  ___/|  | |   Y  \  |   |  \/ /_/  > '
ascii << '  |____|  / ____||   __/ \___  > /_______  /\____/|__|_|  /\___  >__| |___|  /__|___|  /\___  /  '
ascii << '          \/     |__|        \/          \/             \/     \/          \/        \//_____/   '
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
