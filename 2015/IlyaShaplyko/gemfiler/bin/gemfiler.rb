require 'colorize'
require 'optparse'

Dir['../lib/*.rb'].each { |file| require_relative(file) }

parser = OptionParser.new do |opts|
  opts.banner = 'Usage: ./gemfiler.rb [gem_name] [gem_version]'
end
parser.parse!
gem_name, gem_version = ARGV
if gem_name.to_s.empty?
  puts 'Write gem name please'
  exit 1
elsif gem_version.to_s.empty?
  puts 'Write gem version please'
  exit 1
else
  puts "Looking for gem #{gem_name} versions that are #{gem_version}"
end
begin
  all_vers = VersionParser.new(gem_name).fetch
  if all_vers
    filtr_vers = VersionFilter.new(all_vers, gem_version).filter
    ColoredOutput.new(all_vers, filtr_vers).output if filtr_vers
  end
end
