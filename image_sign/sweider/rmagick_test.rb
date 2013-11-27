require "RMagick"
require 'optparse'

include Magick

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: rmagick_test.rb [options]"

  opts.on("-w", "--work_directory PATH", "Directory with photos") do |dir|
    options[:work_directory] = dir
  end

  opts.on("-l", "--location [:top_left, :top_right, :bot_left, :bot_right]", "Location of mark on the photo") do |loc|
    options[:location] = loc
  end

  opts.on("-m", "--mark_path PATH", "Your mark image") do |img|
    options[:mark_img] = img
  end
end.parse!

if (options).count != 3
  p "Not all options getted! Aborted! Try -h for list of options."
  exit(0)
end

errors = []
errors << "Directory #{options[:work_directory]} doesn't exist. Aborted!" if !Dir.exist?(options[:work_directory])
errors << "Wrong location of watermark. Aborted!" if options[:location].match("^top_left$|^top_right$|^bot_left$|^bot_right$").nil?
errors << "Watermark wasn't found. Aborted!" if !File.exist?(options[:mark_img])
errors << "Unsupported format of watermark! Aborted!" if options[:mark_img].split('.')[-1].match("^gif$|^jpg$|^png$").nil?
errors << "Empty work directory. Aborted!" if !Dir.new(options[:work_directory]).any?

if errors.any?
  errors.each { |e| puts e }
  exit(0)
end  


imgs = []

Dir.chdir(options[:work_directory])
Dir.foreach(Dir.pwd) do |file|
   p file.class
   next if file == "." || file == ".."
   imgs << ImagesList.new(file) if !file.split(".")[-1].match("^gif$|^jpg$|^png$").nil?
end

mark = ImageList.new("wm.jpg")

imgs.each do |img|
  scale_factor = (img.columns <= img.rows) ? (img.columns * 0.1 / mark.columns)  :  (img.rows * 0.1 / mark.rows) 
  scaled_mark = mark.scale(scale_factor)
  x_offset, y_offset = 0
  case options[:location]
  when "top_right"
    x_offset = img.columns * 0.95 - scaled_mark.columns
    y_offset = img.rows * 0.05
  when "top_left"
    x_offset = img.columns * 0.05
    y_offset = img.rows * 0.05
  when "bot_left"
    x_offset = img.columns * 0.05
    y_offset = img.rows * 0.95 - scaled_mark.rows
  when "bot_right"
    x_offset = img.columns * 0.95 - scaled_mark.columns
    y_offset = img.rows * 0.95 - scaled_mark.rows
  end
      
  img.composite!(scaled_mark, x_offset, y_offset, OverCompositeOp).write(img.filename)
end

exit(0)

