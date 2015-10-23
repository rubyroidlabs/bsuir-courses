require 'open-uri'
require 'nokogiri'
require 'mixlib/cli'

class Parser
  include Mixlib::CLI
  def set_name(gem_name)
    @name = gem_name
  end

  def connect
    url = "https://rubygems.org/gems/#{@name}/versions"
    begin
      @doc = Nokogiri::HTML(open(url))
      set_versions
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
