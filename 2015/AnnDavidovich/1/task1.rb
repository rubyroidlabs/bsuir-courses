IMG_NUM = 6

def draw_image(number_image)
  file_data = File.read("image#{number_image}.txt")
  puts file_data
  sleep 0.5
  system 'clear'
end

1.times do
  IMG_NUM.times do |i|
    draw_image i + 1
  end
end
