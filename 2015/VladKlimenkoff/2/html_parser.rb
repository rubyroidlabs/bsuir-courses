class HTMLParser
  GEMS_URL = 'https://rubygems.org/gems/'
  def initialize(gem_name)
    @gem_name = gem_name
  end

  def get_versions
    page = Nokogiri::HTML(open(GEMS_URL + @gem_name + "/versions"))
    lis = page.css('li')
    lis.map do |li|
      li.css('a').text
    end
  end
end
