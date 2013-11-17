WIDTH=50
side = true
def clear
  puts "\e[H\e[2J"
end

valic_sim=File.open("valic_pic.txt").to_a
valic_rev=Array.new
valic_sim.each {|str| valic_rev << ' '*WIDTH + str.chomp.reverse!}
valic_temp=Array.new


while true
  i=0
  if (side==true) then

    while i< WIDTH
      valic_sim.map {|str| valic_temp << ' '*i +str}
      puts valic_temp
      i+=1
      sleep 0.1
      clear
      valic_temp.clear
    end
    side=!side

  else

    while i< WIDTH
      valic_rev.map{ |str| valic_temp << str[i .. str.length] }
      puts valic_temp
      sleep 0.1
      i+=1
      clear
      valic_temp.clear
    end
    side=!side
 end
end
