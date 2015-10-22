require_relative './gem-version'
require 'net/https'
require 'json'
require 'uri'

module GemVersionsFilter
  GEM_API_VERS_URL = 'https://rubygems.org/api/v1/versions'
  DATA_FORMAT = 'json'

  class GemVersions
    attr_accessor :gem_versions

    def initialize
      @gem_versions = {}
    end

    def get_versions(gem_name)
      unless gem_versions.has_key?(gem_name)
        uri = URI("#{GEM_API_VERS_URL}/#{gem_name}.#{DATA_FORMAT}")

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(uri.request_uri)
        packages_meta_json = http.request(request).body

        gem_versions[gem_name] = JSON.parse(packages_meta_json).map do |pack_description|
          GemVersion.parse(pack_description['number'])
        end
      end

      gem_versions[gem_name]
    end
  end
end
