#!/usr/bin/env ruby
require_relative '../lib/parameter_parser'
<<<<<<< HEAD
require 'json'

class VersionFetcher

	def initialize(name, *versions)
		@name = name
		@versions = versions
	end

	def fetch
		result = `curl https://rubygems.org/api/v1/search.json?query=#{@name}`
		json = JSON.parse(result)
		json.map! { |s| s["version"] }
		puts json
		puts "*"*20
		json.each do |i|
			if Gem::Dependency.new('', @versions).match?('', i)
				puts i
			end
		end
	end
	
end
=======
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
>>>>>>> 14a84c876475a9609099f3daa249a8c74bd9dfb4
