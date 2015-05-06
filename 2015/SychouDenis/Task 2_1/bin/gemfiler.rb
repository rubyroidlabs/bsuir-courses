require_relative '../lib/version_fetcher'
require_relative '../lib/version_matcher'
require_relative '../lib/version_printer'
require 'optparse'

class Interface
  def initizlize
    @show_all = false
  end

  def parse_options
    OptionParser.new do |opts|
      opts.banner = 'Usage: gemfiler.rb [options][arguments]'

      opts.on('-h', '--help', 'Show help') do |_v|
        puts opts
        exit
      end

      opts.on('-m', '--matched', 'Show only matched') do |v|
        @show_all = v
      end
    end.parse!
  end

  def process
    parse_options

    if ARGV.size < 2
      puts 'Incorrect number of arguments'
    elsif @show_all
      versions = VersionFetcher.get_version_array(ARGV[0])
      conditions = ARGV.slice(1, ARGV.size - 1)
      versions_hash = VersionMatcher.match_versions(versions, conditions)
      VersionPrinter.print_only_matched(versions_hash)
    else
      versions = VersionFetcher.get_version_array(ARGV[0])
      conditions = ARGV.slice(1, ARGV.size - 1)
      versions_hash = VersionMatcher.match_versions(versions, conditions)
      VersionPrinter.print_all_version(versions_hash)
    end
  end
end


i = Interface.new
i.process
