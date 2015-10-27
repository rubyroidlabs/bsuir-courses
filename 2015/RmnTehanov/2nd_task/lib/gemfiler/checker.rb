require 'open-uri'
require 'nokogiri'

class Checker
  def initialize(param)
    @gem_name = param[:name]
    @conditions = Gem::Requirement.new(param[:conditions])
  end

  def get_versions
    page_link = "https://rubygems.org/gems/#{@gem_name}/versions"
    page = Nokogiri::HTML(open(page_link))
    versions = []
    page.css('a.t-list__item').each { |i| versions << Gem::Version.new(i.text) }
    versions
  rescue StandardError
    puts 'Unable to find gem. Check usage by -h or your internet connection.'
    exit
  end

  def check_versions
    get_versions.map! do |current_version|
      if @conditions.satisfied_by?(Gem::Version.new(current_version))
        current_version.to_s
      else
        current_version
      end
    end
  end
end
