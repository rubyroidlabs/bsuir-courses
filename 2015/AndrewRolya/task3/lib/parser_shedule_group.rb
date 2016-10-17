require 'mechanize'

class ParserSheduleGroup
  def initialize(group_number)
    @group_number = group_number
    @url = "http://www.bsuir.by/schedule/schedule.xhtml?id=#{@group_number}"
    @agent = Mechanize.new
  end

  def proffessors_list
    begin
      page = @agent.get(@url)
    rescue
      puts 'Not page_intermediaternet connection'
      exit
    end
    links_list = Hash.new
    teachers_list = Array.new
    page.links_with(href: /schedule/).each do |link|
      links_list[link.text] = link
    end
    links_list.each do |_key, value|
      page_intermediate = value.click
      teachers_list.push page_intermediate.search("//input[@class = 'ui-autocomplete-input ui-inputfield ui-widget ui-state-default ui-corner-all']").attribute('value').value
    end
    teachers_list
  end
end
