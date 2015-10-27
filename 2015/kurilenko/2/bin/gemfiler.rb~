Dir['../lib/*.rb'].each { |f| require_relative f }

if ARGV.size != 2
  raise ArgumentError
end

name, condition = ARGV

if name.match("([0-9a-zA-Z_])*").to_s != name
  raise ArgumentError
end
if condition.match("[!=><~]{1,2}(([0-9])*[.])*([0-9a-zA-z])*").to_s != condition
  raise ArgumentError
end

versions = VersionFetcher.new(name).fetch
versions_filter = VersionFilter.new(condition).filter(versions)
Vizualizer.new(versions_filter, versions).output

