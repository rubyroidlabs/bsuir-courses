require 'mechanize'
agent = Mechanize.new
page ||= agent.get('http://bsuir-helper.ru/lectors/balotka')
reviews = page.search('div.clear-block').to_a
puts reviews