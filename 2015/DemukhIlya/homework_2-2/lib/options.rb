require 'optparse'

class Options

  DEFAULT_DIR = Dir.pwd

  attr_reader :options, :pattern, :files, :dir
  
  def initialize(argv)
  	@dir = DEFAULT_DIR
  	@options = parse(argv)
  	@pattern = argv.shift
  	if argv.empty?
  	  @files = Dir[@dir + '/*.txt']
  	else
  	  @files = argv
  	end
  end

private

  def parse(argv)
  	options = {}

  	OptionParser.new do |opts|
  	  opts.banner = 'Usage: grepkiller [options] pattern files'

  	  opts.on('-a', '--amount', 'Puts amount of lines before and after found line') do |a|
  	  	options[:amount] = a
  	  end

  	  opts.on('-e', '--exp', 'Use regexp instead of string') do |e|
  	  	options[:regexp] = e
  	  end

  	  opts.on('-r', '--recursive_search DIR', String, 'Search recursivly in all files in given directory') do |dir|
  	    @dir = dir
  	  end

  	  opts.on('-z', '--zipped', 'File is zipped') do |z|
  	  	options[:zipped] = z
  	  end

  	  opts.on('-h', '--help', 'Show this message') do
  	  	puts opts
  	  	exit
  	  end

  	  argv = ['-h'] if argv.empty?
  	  opts.parse!(argv)
  	end

  	options
  end
end