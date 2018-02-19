require 'asciiart'
require 'rubygems'
require 'RMagick'
require 'rake'

terminal_width = Rake.application.terminal_width
gif_src = 'walk2.gif'
ascii_img_width = 30

gif = Magick::Image.read(gif_src)
Magick::Image.read(gif_src).each_with_index { |img, i| img.write("img/#{i}.jpg") }

ascii_frames = []
gif.size.times { |i| ascii_frames << AsciiArt.new("img/#{i}.jpg").to_ascii_art(width: ascii_img_width) }

j = -ascii_img_width
loop do
  ascii_frames.each do |frame|
    space_n = j <= 0 ? 0 : j
    a = j <= 0 ? (j.abs) : 0
    b = (terminal_width - j).abs
    frame.each_line { |line| puts ' ' * space_n + line.gsub!(/[|o]/, ' ').to_s[a, b].to_s }
    j += 2
    sleep 0.04
    puts "e[H\e[2J"
    break if j >= terminal_width
  end
  break if j >= terminal_width
end
