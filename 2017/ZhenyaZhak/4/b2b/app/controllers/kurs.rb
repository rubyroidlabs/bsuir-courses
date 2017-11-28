require 'mechanize'

class Kurs
	def self.kursbit
		agent = Mechanize.new
		page = agent.get('https://myfin.by/crypto-rates/bitcoin-usd')
		txt = page.css('.col-md-6.col-xs-12')[0].text.strip
		txt
	end
end