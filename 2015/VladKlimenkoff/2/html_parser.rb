class HTMLParser
  def initialize(gem_name)
    @gem_name = gem_name
  end

  def get_versions
    page = Nokogiri::HTML(open("https://rubygems.org/gems/" + @gem_name + "/versions"));
    lis = page.css('li')
    return lis.map do |li|
      li.css('a').text
    end
  end
end
