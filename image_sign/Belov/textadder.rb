# Доступные опции
# --img somefile.jpg - открытие определенного файла
# --img all - все картинки .jpg текущей директории
# --text sometext - собственно подпись
# --color somecolor (white, black, red) - цвет подписи
# --pos lb - подпись слева снизу
# --pos rb - подпись справа снизу
# --pos lt - подпись слева сверху
# --pos rt - подпись справа сверху

require 'mini_magick'
require 'trollop'

class Text_adder
	def initialize
		@opts = Trollop::options do
			opt :pos, "Text position", :type => :string, :default => "lb"
			opt :img, "Image file", :type => :string, :default => "all"
			opt :text, "Text", :type => :string, :default => "Alex Belov"
			opt :color, "Color", :type => :string, :default => "white"
		end
		if !File.directory? "images_with_text"
			Dir.mkdir "images_with_text"
		end
		operate
	end

	def parse_position
		case @opts[:pos]
			when "lb" # left bottom
				@pos = "10,10"
			when "rb" # rigth bottom
				@pos = "#{@img["width"] - 8*@opts[:text].length},10" # 8 is magic constant =)
			when "lt" # left top
				@pos = "10, #{@img["height"]-20}"
			when "rt" # rigth top
				@pos = "#{@img["width"] - 8*@opts[:text].length}, #{@img["height"]-20}"
		end
	end

	def add_text
		parse_position
		@img.combine_options do |c|
			c.gravity "Southwest"
			c.draw "text #{@pos} \"#{@opts[:text]}\""
			c.fill "#{@opts[:color]}"
		end
	end

	def open_image img_address
		@img_address = img_address
		@img = MiniMagick::Image.open img_address
	end

	def save_image
		@img.write "images_with_text/#{@img_address}"
	end

	def operate
		if @opts[:img] == "all"
			images = Dir.glob "*.jpg"
			images.each do |img_address|
				open_image img_address
				add_text
				save_image
			end
		else
			open_image @opts[:img]
			add_text
			save_image
		end
	end
end 

Text_adder.new