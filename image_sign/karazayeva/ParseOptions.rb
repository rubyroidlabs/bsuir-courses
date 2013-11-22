#PARSING
require 'optparse'
require 'ostruct'

module Options
  
  def self.parse(args)
    
    options = OpenStruct.new
    options.directory = Dir.pwd + "/cats"
    options.sign = "Example Copyright" + self.Copyright
    options.offset = [170,15]
    options.margin = :lower_right
    
    opts = OptionParser.new do |opts|
      opts.banner = "Usage: example.rb -d DIR -s SIGN -o x,y -m TYPE "
      
      opts.on_tail('-h', '--help', 'help you in usage') do 
        puts opts
        exit
      end
      opts.on('-d', '--directory DIR', 'path to dir: [/home/user], for example ') do |dir|
        options.directory = dir
      end
      opts.on('-s', '--sign SIGN', 'Text wich you would insert in ""') do |sign|
        options.sign = sign + self.Copyright
      end
      opts.on("-o", "--offset x,y", Array,
              "padding from the edges in [ X,Y ] format") do |o|
        options.offset = o
      end
      opts.on("-m", "--margin TYPE", [:upper_left, :upper_right, :lower_left, :lower_right],
              "upper_left, upper_right, lower_left or lower_right margin") do |m|
        options.margin = m
      end
    end

    begin 
      opts.parse!(args)
    rescue => e
      puts e.message.capitalize
      puts opts
      exit 
    end
    options
  end
  
  def self.Copyright
    c = "\xC2\xA9"
    c.force_encoding('ascii-8bit')
    c
  end
end

