class Comments
	def initialize(teacher)
    @teacher = teacher
    @page_helper = page_helper
  end

  def connection
    agent = Mechanize.new
		agent.get("http://bsuir-helper.ru/lectors").links.each do |link|
      return link.click if link.text.include? @teacher.split('.').first
    end
    false
  end

  def find_comments
  	if @page_helper
    	text_comments = []
    	@page_helper.parser.css('div#comments').
      	search('.content//p').each do |comment|
        	text_comments.push(comment.text)
      	end
			text_comments
  	end
  end
end

