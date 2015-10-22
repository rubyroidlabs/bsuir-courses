require 'json'
require 'colored'
require "open-uri"
class VersionGet
  def initialize(name)
    @name = name
  end

  def collect
    versions = open("https://rubygems.org/api/v1/versions/#{@name}.json").read
    begin
      JSON.parse(versions).map { |ver| ver['number'] }
    rescue JSON::ParserError
      puts "#{$!}".red
    end
  end
end
