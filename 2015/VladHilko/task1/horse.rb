IMG_NUM = 5

def draw_horse(num_img)
  file_data = File.read("horse#{num_img}.txt")
  puts file_data

  sleep 0.15
  system 'clear'
end

10.times do
  IMG_NUM.times do |i|
    draw_horse i + 1
  end
end

