require 'mechanize'
require 'unicode'

filename = 'words.txt'
file = File.open(filename, 'w')
url = 'http://bsuir-helper.ru'
agent = Mechanize.new
page = agent.get("#{url}/lectors")
names = page.parser.css('.views-row a')
comments = []
names.count.times do |j|
  i = names[j]
  page_lector = agent.get("#{url}/#{i.attributes['href'].value}")
  comments << page_lector.parser.css('.comment .content').map(&:text)
end
words = comments.flatten.to_s.split(/[\s\.\,\!\?\(\)\_\\\/\"\n]/)
h = Hash.new
h.default = 0
words.each do |w|
  h[Unicode::downcase(w)] += 1
end
h = h.sort { |a, b| a[1] <=> b[1] }
h.reverse_each do |key, value|
  file.write("#{key} => #{value} \n")
end
