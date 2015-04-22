#!/usr/bin/env ruby
require_relative '../lib/parameter_parser'
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