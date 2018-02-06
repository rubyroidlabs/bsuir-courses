require 'mechanize'
require_relative 'parser'

class NewNowNextParser
  include Parser
  PAGE = 'http://www.newnownext.com/gay-celebrities-coming-out-2016/10/2016/'.freeze

  private

  def page
    Mechanize.new.get(PAGE)
  end

  def celebrities_list
    page.search('.listicle-container li')
  end

  def name(celebrity)
    celebrity.search('.heading').text
  end

  def orientation(_celebrity)
    ''
  end

  def description(celebrity)
    celebrity.search('.description-container').text.gsub(/\n|\t/, '')
  end
end
