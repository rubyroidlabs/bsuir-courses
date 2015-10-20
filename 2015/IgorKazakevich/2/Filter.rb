require 'nokogiri'
class Filter
  def initialize(data, gem_version)
    @date = data
    @gem_version = gem_version
  end

  def parse_data
    @data_html = Nokogiri::HTML(@date)

    @filter_data = []

    @data_html.xpath('//div//ul//li').each do |data_versions|
      @filter_data.push(data_versions.text.split(' ').first)
      end
  end

  def get_filter_data
    return @filter_data
  end
end
