class Parser
  def initialize
    @agent = Mechanize.new
    @tutor_page = nil
  end

  def go_to_page(url)
    @page = @agent.get(url)
    rescue SocketError
      puts "Internet connection error."
      exit
  end

  def get_tutor_page(tutor_name)
    if link_present?(tutor_name)
      @tutor_page = @page.link_with(text: tutor_name).click
    else
      puts "There is no such tutor. Type -h for example."
      exit
    end
  end

  def link_present?(link_text)
    @page.link_with(text: link_text)
    rescue NoMethodError
      false
  end

end
