require 'json'
require 'mechanize'

class VersionFetcher

  def initialize(name)
    @name = name
  end

  def fetch
    result = "https://rubygems.org/gems/#{@name}/versions"
    agent = Mechanize.new
    begin
      page = agent.get(result)
      versions = page.parser.css('.gem__version-wrap a').map(&:text)
      rescue Mechanize::Error
    end
end
end
