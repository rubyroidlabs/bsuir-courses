require 'mechanize'
require 'nokogiri'
require 'open-uri'

class Parser
  @agent = Mechanize.new

  def self.get_info(link)
    @agent = Mechanize.new
    page = @agent.get(link).search('[id="leftColumn"]')

    page = page.children
    page = page.search('[class = "overViewBox instrument"]')
    page = page.children
    page = page.search('[id = "quotes_summary_current_data"]')
    page = page.children
    page = page.search('[class = "left"]')
    page = page.children
    page = page.search('[class = "inlineblock"]')
    page = page.children
    page = page.search('[class = "top bold inlineblock"]')
    page = page.children
    page = page.search('[id = "last_last"]')
    page = page.children
    page.text
  end
end
