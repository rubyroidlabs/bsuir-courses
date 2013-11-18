WIDTH=100

def cls
puts "\e[H\e[2J" 
end

while true

  file=File.open("zombie.txt")
  zombie_arr=file.to_a
  
  file1=File.open("zombie1.txt")
  zombie_arr1=file1.to_a
  zombie_rev=[]
  zombie_arr1.each{ |zombie| zombie_rev << ' '*WIDTH + zombie.chomp.reverse! }

  s=0.1
  i=1

  while i<WIDTH 
    zombie_arr.collect! do |n|
      n.insert(0,' ')
  end
    s-=s/WIDTH
    puts zombie_arr
    sleep s
    cls
    i=i+1
  end

  g=2
  s=0.1
  while g<WIDTH
    i=0
    while i<WIDTH-g
      zombie_rev.collect! do |n|
        n.insert(0,' ')
      end
      i=i+1
    end
    s-=s/WIDTH
    puts zombie_rev
    sleep s
    cls
    zombie_rev.collect! do |n|
      n.lstrip
    end
    g=g+1
  end
end
