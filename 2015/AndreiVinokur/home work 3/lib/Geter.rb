require 'mechanize'

class Geter
	def initialize
		@agent = Mechanize.new
	end

	def get_bsuir(url_bsuir)
		schedule = @agent.get(url_bsuir)
		teachers = []
		schedule.parser.css('.scheduleStyle').each do |showing|
			teachers = showing.css('tr td a').children.map do |c|
				c.to_s
			end
		end
		teachers = teachers.uniq.map { |el| el.gsub(/\s[а-яА-Я][.]/, '') }
	end

	def search_helper(url_helper)
		search  = @agent.get(url_helper)
		search.parser.css('.box dt a').each do |showing|
				return showing['href']
		end
	end

	def get_reviews(url_reviews)
		reviews = @agent.get(url_reviews)
		reviews.parser.css('.comment .content p').map do |showing|
			showing.children.each { |c| c.remove if c.name == 'br' || c.name == 'p' }
					comment = showing.text.strip
		end
	end

	def get_img(url_reviews)
		reviews = @agent.get(url_reviews)
		reviews.parser.css('.field-item .odd a').map do |showing|
				puts showing['href']
		end
	end
end