class RubyGrep::ArgumentParser
  def initialize()
    @options = {context: 0, tasks: [], pattern: nil, regex: nil, help: false}
    @parser = build_parser()
  end

  def parse!
    @parser.parse!()

    return {help: true} if @options[:help]

    # Take first remaining argument as the pattern
    if @options[:regex].nil?
      raise ArgumentError.new() if ARGV.empty?
      @options[:pattern] = ARGV.shift()
    end

    # Take the rest as file tasks
    ARGV.each do |file|
      @options[:tasks] << RubyGrep::FileTask.new(file)
    end

    # If not files are provided, search in stdin
    if @options[:tasks].empty?
      @options[:tasks] << RubyGrep::StdinTask.new()
    end

    @options
  end

  def help
    @parser.help
  end

  private

  def build_parser
    OptionParser.new do |opts|
      usage1 = 'rubygrep [options] PATTERN [FILE...]'
      usage2 = 'rubygrep [options] -e PATTERN [FILE...]'
      opts.banner = "Usage:\n\t#{usage1}\n\t#{usage2}"

      opts.on('-h', '--help', 'Show help message') do
        @options[:help] = true
      end

      opts.on(
        '-A n',
        '--context n',
        'Show n lines around matches'
      ) do |context|
        @options[:context] = Integer(context)
      end

      opts.on(
          '-e regex',
          '--regex regex',
          'Search for occurrences of a regular expression'
      ) do |regex|
        @options[:regex] = regex
      end

      opts.on(
        '-R dir',
        '--recursive dir',
        'Search in all files in a directory recursively'
      ) do |dir|
        @options[:tasks] << RubyGrep::RecursiveTask.new(dir)
      end

      opts.on(
        '-z gz_file',
        '--zipped gz_file',
        'Search in a gzipped file'
      ) do |gz_file|
        @options[:tasks] << RubyGrep::GZipTask.new(gz_file)
      end
    end
  end
end
