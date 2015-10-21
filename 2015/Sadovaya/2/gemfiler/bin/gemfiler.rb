Dir['../lib/*.rb'].each { |f| require_relative(f) }
require 'optparse'

def parse_option
  OptionParser.new do |opts|
    opts.banner = "Usage: example.rb [options] devise '~>2.0.0'"
    opts.on("-h", "--help", "Show help") do |v|
      puts opts
      exit
    end
  end.parse!
end

parse_option
if ARGV.size < 2
  raise ArgumentError, 'Not enough arguments!'
end
name = ARGV[0]
conditions = ARGV[1..-1]

text_string = Checker.new.check_name_version(name, conditions)

if text_string.length != 0
  raise ArgumentError, text_string
end

versions = VersionFetcher.new.fetch(name)
hash = VersionFilter.new.filter(versions, conditions)
Visualizer.new.visualize(hash, name)
