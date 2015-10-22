module GemVersionsFilter
  class VersionFilter
    attr_reader :filter_descriptors

    def initialize(filter_descriptors)
      @filter_descriptors = filter_descriptors
    end

    def filter_versions(gem_versions)
      matched_versions = gem_versions.select do |version|
        filter_descriptors.all? { |descriptor| descriptor.match?(version) }
      end

      unmatched_versions = gem_versions - matched_versions # get unmatched vers

      {
        matched_versions:matched_versions,
        unmatched_versions:unmatched_versions
      }
    end
  end
end
