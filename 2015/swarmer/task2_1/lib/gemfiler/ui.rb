module Gemfiler::UI
  MATCHING_COLOR = :red

  module_function

  def execute
    args = parse_arguments()
    gem_name = args[:name]
    version_specs = args[:versions]

    begin
      fetcher = Gemfiler::VersionFetcher.new(gem_name)
      fetcher.fetch_from_rubygems()
    rescue Gemfiler::FetchError => e
      fail!(e.to_s)
    end

    begin
      matcher = Gemfiler::VersionMatcher.new(version_specs, fetcher.versions)

      matcher.each_with_flag do |version, matches|
        puts matches ? version.colorize(MATCHING_COLOR) : version
      end
    rescue Gemfiler::MatchError => e
      fail!(e.to_s)
    end
  end

  def parse_arguments
    help = false

    parser = OptionParser.new do |opts|
      opts.banner = 'Usage: gemfiler [options] <gemname> <version_spec>'

      opts.on('-h', '--help', 'Show help message') do
        help = true
      end
    end

    parser.parse!()

    if help
      puts parser.help
      exit
    elsif ARGV.size < 2
      fail!(parser.help)
    end

    gem_name, *version_specs = ARGV
    {name: gem_name, versions: version_specs}
  end

  def fail!(message)
    puts message
    exit 1
  end
end
