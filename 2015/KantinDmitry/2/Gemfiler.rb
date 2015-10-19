require_relative 'Gem_versions_getter.rb'
require_relative 'Versions_printer.rb'

begin
  gem_versions_getter = GemVersionsGetter.new
  versions_array = gem_versions_getter.get_versions(ARGV[0])
  VersionsPrinter.output_with_condition(versions_array, ARGV[1], ARGV[2])
rescue StandardError => e
  puts e.message.red
end
