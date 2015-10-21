Dir['./lib/*.rb'].each { |f| require_relative(f) }

if ARGV.count < 2
  raise ArgumentError.new('Invalid count argument')
end
gem_version = []
ARGV.each do |argument|
  gem_version << argument
end
gem_version.shift
gem_name = ARGV[0]
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
