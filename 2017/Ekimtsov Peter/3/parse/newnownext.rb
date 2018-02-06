require 'mechanize'

# NewNowNext list parser
class NewNowNextParser
  URL_1 = 'http://www.newnownext.com/gay-celebrities-coming-out-2016/10/2016/'.freeze
  URL_2 = 'http://www.newnownext.com/gay-celebrities-coming-out-2017/10/2017/'.freeze

  attr_reader :names

  def initialize
    @agent = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
    @page1 = @agent.get(URL_1)
    @page2 = @agent.get(URL_2)
    @names = []
    names_info
  end

  private

  def names_info
    @page1.css('.listicle-container').css('.heading').each do |name|
      @names.push(name.text)
    end
    @page2.css('.listicle-container').css('.heading').each do |name|
      @names.push(name.text)
    end
  end
end
