require 'json'
class Fetcher

  def initialize(name)
    @name = name
  end

  def fetch
    result = `curl https://rubygems.org/api/v1/versions/#{@name}.json`
    json = JSON.parse(result)
    raise if json.empty?
    json.map! { |s| s['number'] }
  rescue
    puts 'Wrong name of gem'
    Kernel.abort
  end
end
