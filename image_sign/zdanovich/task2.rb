require_relative 'parser'

require 'mini_magick'

options = ParseParam.parse(ARGV)

position = options[:position].split(',')
case position[0]

when "top"
  if position[1] == "left" 
    options[:position] = "NorthWest"
  else 
    options[:position] = "NorthEast"
  end

when "bottom"  
  if position[1] == "left"  
    options[:position] = "SouthWest"
  else 
    options[:position] = "SouthEast"
  end

else  options[:position] = "SouthWest"
end


Dir.chdir(options[:dir])

photo_array = Dir.glob("*{jpg,png}").map { |photo| photo = Dir.getwd + "/#{photo}"}.each do |photo|

  image = MiniMagick::Image.open(photo)    
  image.combine_options do |c|
    c.gravity options[:position]
    c.pointsize 33
    c.fill options[:color]
    c.draw "text  #{options[:indent]},#{options[:indent]}  '#{options[:signature]}'"
  end
  image.write(photo)
end


  