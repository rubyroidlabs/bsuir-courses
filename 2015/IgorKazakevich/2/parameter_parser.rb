require 'open-uri'
require 'slop'
require 'nokogiri'

class ParameterParser
  def initialize
    @input_string = Slop.parse { |s| s.string '' }
  end

  def parse
    @search_gem = @input_string.arguments[0]

    @requirements = Array.new(2) do |i|
      Gem::Requirement.new(@input_string.arguments[i + 1])
    end

    @address = "https://rubygems.org/gems/#{@search_gem}/versions"
    parse_html_data

  rescue StandardError
    puts 'Error parsing data! Check your input and connection to the internet.'
    exit
  end

  def parse_html_data
    @filter_data = Array.new

    Nokogiri::HTML(open(@address)).xpath('//div//ul//li').each do |version|
      @filter_data.push(Gem::Version.new(version.text.split(' ').first))
    end
  end
end
