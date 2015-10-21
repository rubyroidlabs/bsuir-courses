require 'open-uri'
require 'nokogiri'

class Parse
  def initialize(gem_name)
    @name = gem_name
  end

  def connect
    begin
      url = "https://rubygems.org/gems/#{@name}/versions"
      @doc = Nokogiri::HTML(open(url))
     self.set_versions
    rescue => ex
      puts "OH SHI!.. #{ex.class}: #{ex.message}"
    end
  end

  def set_versions
    @versions = []
    begin
      @doc.css('main li').each do |li|
      @versions.push(li.text.split.first)
    end
    rescue => ex
      puts "Can not read document! #{ex.class}: #{ex.message}"
    end
  end

  def get_versions
    @versions
  end
end
