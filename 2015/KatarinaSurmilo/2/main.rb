require_relative './gem-version-filter/version-filter-descriptor'
require_relative './gem-version-filter/version-filter'
require_relative './gem-version-filter/gem-versions'
require_relative './gem-version-filter/gem-version'
require_relative './gem-version-filter/args-parser'
require 'colorize'

params = GemVersionsFilter::ArgsParser.parse(ARGV)

if params.has_key?(:gem_name) && params.has_key?(:versions)

  versions = GemVersionsFilter::GemVersions.new.get_versions(params[:gem_name])

  filter_descriptors = params[:versions].map do |vers_expression|
    GemVersionsFilter::VersionFilterDescriptor.parse(vers_expression)
  end

  version_filter = GemVersionsFilter::VersionFilter.new(filter_descriptors)

  filtred_results = version_filter.filter_versions(versions)

  filtred_results[:matched_versions].each do |version|
    puts version.to_s.colorize(:red)
  end

  filtred_results[:unmatched_versions].each do |version|
    puts version
  end

else
  puts 'Please use --help or -h to get help about cli params'
end
