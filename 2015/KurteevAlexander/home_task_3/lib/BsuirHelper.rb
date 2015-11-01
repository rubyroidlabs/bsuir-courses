require 'mechanize'
class BsuirHelper
  def initialize
    @lector_list_bh = []
    @agent = Mechanize.new
    @page =@agent.get(BSUIR_HELPER_LECTORS_LINK)
  end

  def lectors_list
    @list = @page.links_with(href: LECTOR_SEARCH_FORM_BH )
    @list.each_with_index do |lect, ind| 
      @name = lect.to_s
      @fio = @name.split
      @name = @fio[0] +"\s"+ @fio[1][0] + ".\s" + @fio[2][0] + '.'
      @link = BSUIR_HELPER_LINK + lect.uri.to_s
      @lector_list_bh[ind] = { link: @link, name: @name }
    end
    @lector_list_bh
  end
end
