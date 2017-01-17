require 'optparse'
require 'RMagick'
include Magick


class Pictures

  attr_reader :options

  def initialize
   @options = {}
  end

  def parse_options
    OptionParser.new do |opts|
      @options[:padding] = 0
      opts.banner = "Usage: sign.rb [@options]" 
      opts.on("-p","--padding size",Integer,"Padding(Optional)")   {|opt| @options[:padding] = opt}
      opts.on("-l","--location list",Array, 
              "Location of signature:top/down,right/left(Mandatory)")  {|opt| @options[:location] = opt} 
      opts.on("-d","--directory name","Directory with photos(Mandatory)")  {|opt| @options[:directory] = opt}
      opts.on("-s","--signature way","Picture with signature(Mandatory)")  {|opt| @options[:signature] = opt}
      begin
        opts.parse!
      rescue OptionParser::InvalidOption => e
        puts e
        puts opts.help
        exit(1)
      end
      if @options[:directory].nil? || @options[:signature].nil? || @options[:location].nil?
        puts opts.help; exit(1);
      end
      if @options[:location].size != 2 
        puts "option --location expects 2 parameteres"; exit(1);
      end
      @options[:location].each do |loc|
        loc.downcase! 
        unless ["top","t","down","d","right","r","left","l"].include?(loc) 
          puts "Unknown parameter #{loc}"
          puts opts.help; exit(1);
        end 
      end
      loc = @options[:location]	
      if ["top","t","down","d"].include?(loc[0]) && ["top","t","down","d"].include?(loc[1]) ||
         ["left","l","right","r"].include?(loc[0]) && ["left","l","right","r"].include?(loc[1])
        puts "Wrong set op parametres(#{loc[0]},#{loc[1]})"
        puts opts.help; exit(1);
      end
    end
  end

  def sign
    sign = Magick::Image.read(@options[:signature]).first
    dir = Dir.new(@options[:directory])
    Dir.chdir(dir)
    Dir.mkdir("signed") unless Dir.exist?("signed") 
  
    Dir.foreach(dir) do |picture|
      coord = {}
      next if picture == '.' || picture == '..' || Dir.exist?(picture)
      image = Magick::Image.read(picture).first
      signed = ImageList.new
      @options[:location].include?("t") || @options[:location].include?("top") ? coord[:y] = 0 + @options[:padding]: coord[:y] = image.rows - sign.rows - @options[:padding]
      @options[:location].include?("l") || @options[:location].include?("left") ? coord[:x] = @options[:padding] : coord[:x] = image.columns - sign.columns - @options[:padding]
      if coord[:x] < 0 || coord[:y] < 0 
        puts "Photo #{picture} is too small for signing such way"
        next
      end
      signed = image.composite!(sign, coord[:x], coord[:y], Magick::OverCompositeOp)
      signed.write("signed/#{picture}_s.jpg")
    end
    puts "Successfully signed!"
  end

end

pict = Pictures.new
pict.parse_options
pict.sign
