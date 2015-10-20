require 'open-uri'
require 'nokogiri'

module Parser

  public
  
  def self.parse_str(name)
    begin
      url = "https://rubygems.org/gems/#{name}/versions"
      html = open(url)
      doc = Nokogiri::HTML(html)
      versions = []
      doc.css('.versions').each do |version|
        versions = version.css('.gem__version-wrap a').map(&:text)
      end
    rescue StandardError => exc
      puts exc.message
      exit
    end
    versions
  end
end
