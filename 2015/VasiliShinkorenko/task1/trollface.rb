# Start

@arr = []

f = File.open("ascii.txt", "r") 
f.each { |line| @arr << line }
f.close

def sleep_and_clear
  sleep 0.033
  print "\e[2J\e[f"
end

def insert_spaces
  puts @arr.map! { |line| line.insert(0, ' ') }
  sleep_and_clear
end

def sub_with_star
  puts @arr.map { |line| line.gsub(/\w/, '*') }
  sleep_and_clear
end

def sub_with_zero
  puts @arr.map { |line| line.gsub(/\w/, '0') }
  sleep_and_clear
end

60.times do 
  insert_spaces
  sub_with_star
  sub_with_zero
end
