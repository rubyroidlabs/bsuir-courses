width_display = %x(tput cols).to_i

puts "Введите глубиу дерева"
deep = gets.to_i

if ENV["BASE_NUMBER"].nil?
  puts "Введите базовый номер"
  base_number = gets.to_i
else
  base_number = ENV["BASE_NUMBER"].to_i
end

(deep + 1).times do |i|
  arr = (0..i).map do |j|
    base_number * ((1..i).inject(:*) || 1) / (((1..j).inject(:*) || 1) * ((1..(i - j)).inject(:*) || 1))
  end
  str_elements = arr.join("  ")
  puts " " * i.to_s.length +  "   " + " " * ((width_display - str_elements.length) / 2) + arr[1..-2].map{ |a| a.to_s.length }.map{|k| (k > 2) ? "\\" + "_" * (k - 2) + "/" : "\\/"}.join("  ")
  puts "#{i}" + " " * ((width_display - str_elements.length) / 2) + str_elements
end