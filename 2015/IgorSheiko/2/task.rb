Dir[File.expand_path('./../lib/*.rb', __FILE__)].each { |f| require(f) }
require 'optparse'

a = ParsingCommandLine.new
if a.opts_count < 2
  raise ArgumentError.new('Invalid count argument')
end
gem_version = a.parsing_command_line
gem_name = a.get_gem_name
versions = GetAllVersions.new(gem_name).get_all_versions
versions = versions.map { |version| Gem::Version.new(version) }
true_versions = versions
search_true_gems = ParseVersion.new
gem_version.each do |parametr|
  operator, version = parametr.split
  version = Gem::Version.new(version)
  true_versions = search_true_gems.filter(operator, version, true_versions)
end
ColoredOutput.new(versions, true_versions).colored_output
