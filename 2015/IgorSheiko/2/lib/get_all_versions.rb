require 'mechanize'

class GetAllVersions
  def initialize(gem_name)
    @gem_name = gem_name
  end

  def get_all_versions
    url = "https://rubygems.org/gems/#{@gem_name}/versions"
    agent = Mechanize.new
    begin
      page = agent.get(url)
      versions = page.parser.css('.gem__version-wrap a').map(&:text)
    rescue Mechanize::Error
      puts 'This rubygem could not be found.'
    end
  end
end
