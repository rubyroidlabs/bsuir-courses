module RubyGrep::UI
  module_function

  def execute
    args = parse_arguments()
    matcher = args[:matcher]
    tasks = args[:tasks]

    tasks.each do |task|
      task.each_file do |file|
        puts matcher.search_file(file)
      end
    end
  rescue StandardError => e
    fail(e.to_s)
  end

  def parse_arguments
    parser = RubyGrep::ArgumentParser.new()

    begin
      args = parser.parse!()
    rescue ArgumentError, TypeError
      fail(parser.help)
    end

    if args[:help]
      puts parser.help
      exit
    end

    if args[:regex].nil?
      matcher = RubyGrep::TextMatcher.new(args[:pattern], args[:context])
    else
      matcher = RubyGrep::RegexMatcher.new(args[:regex], args[:context])
    end

    {tasks: args[:tasks], matcher: matcher}
  end

  def fail(message)
    puts message
    exit 1
  end
end
