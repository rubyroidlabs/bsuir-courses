require 'open-uri'
require 'colorize'

require_relative 'url_parse.rb'
require_relative 'input_secure.rb'
require_relative 'input_parse.rb'
require_relative 'filter.rb'

if InputSecure.check?(ARGV)
  input_parse = InputParse.new(ARGV)
else
  exit
end

url = "https://rubygems.org/gems/#{input_parse.gem_name}/versions"
versions = URLParse.find_versions(url)
filter = Filter.new(versions, input_parse.filter_options)
filter.output
