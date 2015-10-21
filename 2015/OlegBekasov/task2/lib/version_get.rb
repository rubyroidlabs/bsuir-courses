require 'json'
require 'colored'
class VersionGet
  def initialize(name)
    @name = name
  end
  def collect    
    versions = `curl https://rubygems.org/api/v1/versions/#{@name}.json`
    begin
      JSON.parse(versions).map { |ver| ver["number"] }
    rescue JSON::ParserError
      puts "#{$!}".red
    end
  end
end