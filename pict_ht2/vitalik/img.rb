require 'RMagick'
include Magick

if ARGV.size != 2
  puts "Expected 2 args - name of dir with imgs and name of sign-pict"
  exit
end
dir_with_imgs, signature = ARGV

sign = Magick::Image.read(signature)
dir = Dir.new(dir_with_imgs)
Dir.chdir(dir)
Dir.mkdir("signed") unless Dir.exist?("signed")

Dir.foreach(dir) do |picture|
  next if picture == '.' || picture == '..' || Dir.exist?(picture)
  image = Magick::Image.read(picture)
  signed = ImageList.new
  signed = image.first.composite!(sign.first, image[0].columns - sign[0].columns, 0, Magick::OverCompositeOp)
  signed.write("signed/#{picture}_s.jpg")
end

