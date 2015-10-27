require 'slop'
require 'open-uri'
require 'nokogiri'
require 'colored'

class Parser
  def initialize(args)
    @args = args
  end

  def parse_param
    Slop.parse(@args) do |o|
      o.banner = "Usage: ruby demo.rb GEM_NAME [gem_version].\nExample:
      ./gemfiler devise '~> 2.1.3'
      ./gemfiler rails '>= 3.1'
      ./gemfiler rails '>= 3.1' '< 4.0'"
      o.on '-h', '--help', 'Help info' do
        puts o
        exit
      end
    end
    gem_name = @args.shift
    conditions = []
    @args.each { |item| conditions << item }
    { name: gem_name, conditions: conditions }
  end
end

class CheckVersions
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

class Output
  def initialize(checked_versions)
    @checked_versions = checked_versions
  end

  def show_versions
    @checked_versions.each do |current_version|
      if current_version.class == String
        puts current_version.red
      else
        puts current_version
      end
    end
  end
end

param = Parser.new(ARGV).parse_param
checked_versions = CheckVersions.new(param).check_versions
Output.new(checked_versions).show_versions
