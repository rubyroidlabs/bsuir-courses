require 'optparse'
require 'zlib'

class MyGrep

  def initialize
    parse_options
    @pattern = ARGV.shift
  end

  def parse_options
    @options = {}
    OptionParser.new do |opts|
      opts.banner = 'Usage: gemfiler.rb [options][arguments]'

      opts.on('-h', '--help', 'Show help') do |v|
        puts opts
        exit
      end

      opts.on('-A', '--A', 'Show next and previous strings') do |v|
        @options[:A] = true
      end

      opts.on('-R', '--recursive', 'Find in all files in directory') do |v|
        @options[:R] = true
      end

      opts.on('-z', '--gzip', 'Find in gzip file') do |v|
        @options[:z] = true
      end

      opts.on('-e', '--regex', 'Find by regular expression') do |v|
        @options[:e] = true
      end

    end.parse!
  end

  def parse_array(string_array)
    string_array.each_with_index do |string, index|

      reg = (@options[:e] && Regexp.new(@pattern).match(string))
      not_reg = (!@options[:e] && string.include?(@pattern))

      if reg || not_reg
        if @options[:A]
          if index > 0
            puts string_array[index-1]
          end
          puts string
          if index < string_array.size - 1
            puts string_array[index+1]
          end
        else
          puts string
        end
      end
    end
  end

  def process
    if @options[:R]
      files_in_dir = Dir.entries('.').select {|f| File.file? f}
      files_in_dir.each do |name|
        parse_array(File.open(name).to_a)
      end
    elsif @options[:z]
      if @options[:A]

      else
        Zlib::GzipReader.open(ARGV.shift) do |gz|
          parse_array(gz.read.split("\n"))
        end
      end
    else
      ARGV.each do |name|
        parse_array(File.open(name).to_a)
      end
    end
  end

  private :parse_array, :parse_options

end

grep = MyGrep.new
grep.process