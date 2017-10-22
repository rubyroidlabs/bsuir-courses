require_relative 'restorator.rb'

a=Restorator.new
result=a.next
loop do
  result.each do |res|
    puts "#{res[0]} vs #{res[1]}"
    puts "#{res[0]} - #{res[2]}"
    puts "#{res[1]} - #{res[3]}"
    if res[2]>res[3]
      puts "#{res[0]} - WINNER !"
    else
      puts "#{res[1]} - WINNER !"
    end
  end
  puts
  puts
  puts
  result=a.next
end
