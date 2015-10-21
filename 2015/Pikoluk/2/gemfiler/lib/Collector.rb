require 'json'
require 'pry'
class Collector
  attr_reader :gem_name

  def initialize(gem_name)
    @gem_name = gem_name
  end

  def fetch
    data = `curl https://rubygems.org/api/v1/versions/#{gem_name}.json`
    begin
      json = JSON.parse(data)
      json.map { |s| s["number"]}
    rescue JSON::ParserError
      puts 'You stupid :Ъ'
    end
  end
end
