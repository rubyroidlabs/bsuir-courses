#!/usr/bin/env ruby
require_relative '../lib/parameter_parser'
require 'json'

class VersionFetcher

	def initialize(name)
		@name = name
		# @version = version
	end

	def fetch
		result = 'curl https://rubygems.org/api/v1/search.json?query=#{@name}'
		# puts result
		json = JSON.parse(result)
		# puts json.first
		json.map! { |s| s["version"] }
		puts json
		


	end
	
end