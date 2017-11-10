require 'mechanize'
require 'json'

require './parser1.rb'
require './parser2.rb'
require './parser3.rb'
require './parser4.rb'

url1 = 'http://www.buzzcelebrities.com/celebrities-openly-bisexual/'
url2 = 'http://www.thethings.com/15-bisexual-celebrities-that-might-actually-surprise-you/'
url3 = 'http://www.theclever.com/15-celebs-you-didnt-know-were-gay-or-bisexual'
url4 = 'https://www.tenuz.com/list-of-gay-celebrities/'

agent = Mechanize.new

page1 = agent.get(url1)
page2 = agent.get(url2)
page3 = agent.get(url3)
page4 = agent.get(url4)

parser1 = Parser1.new(page1).take_data
parser2 = Parser2.new(page2).take_data
parser3 = Parser3.new(page3).take_data
parser4 = Parser4.new(page4).take_data

data = parser1 + parser2 + parser3 + parser4
data_uniq = []
condition = true

data.each do |hash|
  data_uniq.each do |i|
    if i[:actors] == hash[:actors]
      condition = false
      break
    else
      condition = true
    end
  end
  data_uniq << hash if condition
end

data_json = JSON.generate(data_uniq)

f = File.new('data.json', 'w')
f.puts(data_json)
f.close
