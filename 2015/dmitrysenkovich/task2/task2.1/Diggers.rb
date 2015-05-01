require 'rubygems'
require 'nokogiri'
require 'rest-client'

module Diggers
  SEARCH_URL = 'https://rubygems.org/search?utf8=%E2%9C%93&query='
  GEM_URL = 'https://rubygems.org/gems/'
  EXACT_GEM_NAME_NODE = 'h2.gems__gem__name'
  VERSION_WRAP_NODE = 'li.gem__version-wrap'
  VERSION_ITEM_NODE = 'a.t-list__item'

  class AwesomeDigger
    def self.get_search_page(name)
      search_url = SEARCH_URL + name
      search_page = Nokogiri::HTML(RestClient.get(search_url))
      search_page
    end

    def self.get_found_exact_name(name)
      search_page = get_search_page(name)
      found_exact_name = search_page.css(EXACT_GEM_NAME_NODE)[0].text.split[0]
      found_exact_name
    end

    def self.get_gem_page(name)
      gem_url = GEM_URL + name
      gem_page = Nokogiri::HTML(RestClient.get(gem_url))
      gem_page
    end

    def self.get_versions(name)
      gem_page = get_gem_page(name)
      versions = gem_page.css(VERSION_WRAP_NODE).css(VERSION_ITEM_NODE).map { |x| x.text }
      versions
    end
  end
end
