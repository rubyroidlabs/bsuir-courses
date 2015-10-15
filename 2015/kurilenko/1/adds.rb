
def first(n)
  n.times { print " " }
  puts "           ████████\r"
  n.times { print " " }
  puts "          ███▄███████ \r"
  n.times { print " " }
  puts "          ███████████\r"
  n.times { print " " }
  puts "          ███████████\r"
  n.times { print " " }
  puts "          ██████\r"
  n.times { print " " }
  puts "          █████████\r"
  n.times { print " " }
  puts "█       ███████\r"
  n.times { print " " }
  puts "██    ████████████\r"
  n.times { print " " }
  puts "███  ██████████  █\r"
  n.times { print " " }
  puts "███████████████\r"
  n.times { print " " }
  puts "███████████████\r"
  n.times { print " " }
  puts " █████████████\r"
  n.times { print " " } 
  puts "  ███████████\r"
  n.times { print " " }
  puts "    ████████\r" 
  n.times { print " " }
  puts "     ███  ██\r" 
  n.times { print " " }
  puts "     ██    █\r" 
  n.times { print " " }
  puts "     █     █\r"
  n.times { print " " }
  puts "     ██    ██\r"
end

def second(n)
  n.times { print " " }
  puts "           ████████\r"
  n.times { print " " }
  puts "          ███████████ \r"
  n.times { print " " }
  puts "          ███████████\r"
  n.times { print " " }
  puts "          ███████████\r"
  n.times { print " " }
  puts "          ██████\r"
  n.times { print " " }
  puts "          █████████\r"
  n.times { print " " }
  puts " █      ███████\r"
  n.times { print " " }
  puts " ██   ████████████\r"
  n.times { print " " }
  puts " ███ ██████████  █\r"
  n.times { print " " }
  puts " ██████████████\r"
  n.times { print " " }
  puts " ██████████████\r"
  n.times { print " " }
  puts "  ████████████\r"
  n.times { print " " } 
  puts "   ██████████\r"
  n.times { print " " }
  puts "    ████████\r" 
  n.times { print " " }
  puts "     ███  ██\r" 
  n.times { print " " }
  puts "     ██    █\r" 
  n.times { print " " }
  puts "     █     ██\r"
  n.times { print " " }
  puts "     ██     \r"
end

def third(n)
  n.times { print " " }
  puts "           ████████\r"
  n.times { print " " }
  puts "          ███▄███████ \r"
  n.times { print " " }
  puts "          ███████████\r"
  n.times { print " " }
  puts "          ███████████\r"
  n.times { print " " }
  puts "          ██████\r"
  n.times { print " " }
  puts "          █████████\r"
  n.times { print " " }
  puts "█       ███████\r"
  n.times { print " " }
  puts "██    █████████████\r"
  n.times { print " " }
  puts "███  ██████████  \r"
  n.times { print " " }
  puts "███████████████\r"
  n.times { print " " }
  puts "███████████████\r"
  n.times { print " " }
  puts " █████████████\r"
  n.times { print " " } 
  puts "  ███████████\r"
  n.times { print " " }
  puts "    ████████\r" 
  n.times { print " " }
  puts "     ███  ██\r" 
  n.times { print " " }
  puts "     █    █\r" 
  n.times { print " " }
  puts "     ██   █\r"
  n.times { print " " }
  puts "          ██\r"
end

i = 0
FRAMES=30


while i<FRAMES
  first(i*2)
  sleep(0.08)
  system("clear")
  second(i*2)
  sleep(0.08)
  system("clear")
  third(i*2)
  sleep(0.08)
  system("clear")
  i += 1	
end
