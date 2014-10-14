require 'optparse'

class ParseParam

  def self.parse(args)

    #default param
    options = {:indent => 20, :position => "top,left", :dir => "/", :signature => "by Yegor", :color => "blue"}
    
    opt_parser = OptionParser.new do |opts|

      opts.banner = "Usage: task2.rb [options]"

      opts.on("-i", "--indent [indent]", "Indent in pixels") { |int| options[:indent] = int }

      opts.on("-p", "--position [position]", "Sign position [top, left]") { |pos| options[:position] = pos }
  
      opts.on("-d", "--dir [dir]", "Path to the folder with photoes") { |dir| options[:dir] = dir }
  
      opts.on("-s", "--sign [sign]", "Sign text ") { |sign| options[:signature] = sign }
  
      opts.on("-c", "--color [color]", "Set color ") { |color| options[:color] = color }

      opts.on("-h", "--help", "Show help") do
        puts opts
        exit
      end
    end
    
    opt_parser.parse!(args)
    options  
  end

end
