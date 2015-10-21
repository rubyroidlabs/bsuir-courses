require 'json'

class VersionParser
  attr_reader :gem_name

  def initialize(gem_name)
    @gem_name = gem_name
  end

  def fetch
    gem_data = `curl https://rubygems.org/api/v1/versions/#{gem_name}.json`
    begin
      json = JSON.parse(gem_data)
      json.map { |s| s["number"] }
    rescue JSON::ParserError
       puts "Error in writing gem name".green
    end
  end
end
