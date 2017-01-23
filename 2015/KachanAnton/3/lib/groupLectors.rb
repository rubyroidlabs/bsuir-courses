require 'mechanize'

class GroupLectors
  def initialize(group_number)
    @group_number = group_number
    @url = "http://www.bsuir.by/schedule/schedule.xhtml?id=#{@group_number}"
    @lectors_list = Array.new
  end

  def get_list
    Mechanize.new.get(@url).links_with(href: /schedule/).each do |name|
      if !@lectors_list.include?(name.text)
        @lectors_list.push(name.text)
      end
    end
    @lectors_list
  end
end
