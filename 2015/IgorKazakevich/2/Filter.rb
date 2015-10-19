require 'nokogiri'
class Filter
  def initialize(data, gemVersion)
    @date = data
    @gemVersion = gemVersion
  end

  def parseData()
    @data_html = Nokogiri::HTML(@date)

    @filterData = []

    @data_html.xpath('//div//ul//li').each do |data_versions|
      @filterData.push(data_versions.text.split(' ').first)    
      end
  end

  def getFilterData()
    return @filterData
  end
end
