require 'optparse'

class Parser

  attr_reader :name,
              :version

  def parse

    parser = OptionParser.new do|opts|
      opts.banner = 'Usage: gemfiler.rb [options]'

      opts.on('-h') do
        help_string = File.read('help')
        puts help_string
        exit
      end
    end

    parser.parse!

    @name, *@version = ARGV

    if @name.nil?
      print 'Enter name of gem: '
      @name = gets.chomp
    end

    if @version.nil?
      @version = '>= 0.0'
    end

  end

end