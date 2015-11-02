require 'mechanize'
class BsuirGroup
  def initialize
    @lector_list = []
    @agent = Mechanize.new
    @page = @agent.get(BSUIR_LINK)
    @form = @page.form(GROUP_FORM)
  rescue
    raise 'Failed intetnet connection'
  end

  def parse_group
    @form[GROUP_BOX] = ARGV[0]
    @button = @form.buttons.first
    @page = @agent.submit(@form, @button)
  end

  def page_parse
    parse_group
    @list = @page.links_with(href: LECTOR_SEARCH_FORM)
    EXTRALS.times { @list.pop }
    if !@list.pop
      raise 'Group not found'
    else
      @list.each_with_index { |lect, ind| @lector_list[ind] = lect.to_s }
      @lector_list.uniq!.sort!
    end
  end
end
