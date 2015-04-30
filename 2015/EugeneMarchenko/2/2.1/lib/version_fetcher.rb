#!/usr/bin/env ruby
require_relative '../lib/parameter_parser'
require_relative '../lib/gem_version_filter'
require 'json'

SEARCH_JSON_STRING = 'version'
CHECK_RESULT_STRING = '[]'
CURL_STRING = 'curl --silent https://rubygems.org/api/v1/search.json?query='

# Author::    Eugene Marchenko  (mailto:3.marchenko@gmail.com)
# Copyright:: Copyright (c) 2015 Standalone Programmer
# License::   Distributes under the same terms as Ruby

# This class holds the fetch method takes no arguments
# Result: call GemVersionFilter class with filter
# method to get filtered versions of GEM
class VersionFetcher
  def initialize(name, *versions)
    @name = name
    @versions = versions
  end

  def fetch
    result = `#{CURL_STRING}#{@name}`
    puts "Can not find GEM: #{@name}" if result == CHECK_RESULT_STRING
    json = JSON.parse(result)
    json.map! { |s| s[SEARCH_JSON_STRING] }
    GemVersionFilter.new.filter(json, @versions)
  end
end
