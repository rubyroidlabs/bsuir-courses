WIDTH=100

def cls
  puts "\e[H\e[2J" 
end

loop do

  file=File.open("zombie.txt")
  zombie_arr=file.to_a
  
  file1=File.open("zombie1.txt")
  zombie_arr1=file1.to_a
  zombie_rev=[]
  zombie_rev = zombie_arr1.map { |zombie| ' '*WIDTH + zombie.chomp.reverse! }

  S=0.1

  WIDTH.times do |i| 
    zombie_arr.map{|n| n.insert(0,' ')}
    puts zombie_arr
    sleep S
    cls
    i=i+1
  end
 
  g=2
  while g<WIDTH
    i=0
    while i<WIDTH-g
      zombie_rev.map{|n| n.insert(0,' ')}
      i+=1
    end
    puts zombie_rev
    sleep S
    cls
    zombie_rev.map!(&:lstrip)  
    g+=1
  end

end
