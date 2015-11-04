require 'zip'
require 'slop'

class Parser
  attr_reader :opt_a
  attr_reader :opt_e
  attr_reader :array
  attr_reader :find_text

  def initialize  
    @opts = Slop.parse do |o|
      o.integer '-A'
      o.regexp '-e' 
      o.bool '-R'
      o.string '-z'
      o.on '-h', '--help' do
        puts "Examples:\n------------"
        puts 'grep -A 1 ab 1.txt'
        puts "grep -A 1 -e 'sf' -R 1.txt 2.txt"
        puts "grep -A 1 -e 'sf' -R 2.txt 1.txt"
        exit
      end
    end

    @opt_a = @opts[:A]
    @opt_e = @opts[:e]
    @array = []
  end

  def parse
    check_opt_e
    check_opt_r
    check_opt_z

    unless @files.nil?
      @files.each do |file|
        f = File.open(file, 'r')
        @array << f.read.split("\n")
        f.close
      end
    end
    @array = @array.join(' ').split(' ')
  rescue StandardError
    puts 'Error! Check your input data!'
    exit
  end

  def check_opt_z
    if @opts[:z]
      Zip::File.open(@opts[:z]) do |zipfile|
        zipfile.each do |file|
          @array << file.get_input_stream.read.split("\n")
        end
      end
    end
  end

  def check_opt_r
    if @opts[:R]
      @files = Dir.glob('**/*').find_all { |file_name| file_name.end_with?('.txt')}
    end
  end

  def check_opt_e
    if @opts[:e]
      @files = @opts.arguments[0..-1]
    else
      @find_text = @opts.arguments[0]
      @files = @opts.arguments[1..-1]
    end
  end
end
