require './battle.rb'
require './printer.rb'
require 'mechanize'

url_page = 'https://genius.com/artists/King-of-the-dot'
review_links = []

agent = Mechanize.new
agent.get(url_page)
page = agent.page.link_with(text: /Show all songs by King of the Dot/).click

q = 0
# Open 1, 2 and 3 page
while q < 2
  review_links << page.links_with(href: %r{https://genius.com/King-of-the-dot})
  review_links.flatten!
  page = agent.page.link_with(text: /Next »/).click
  q += 1
end

review_links.each do |el|
  review_links.delete(el) unless el.text.include? 'vs'
end

review_links.delete_at(139)

evnname = ENV['NAME']
evncrit = ENV['CRITERIA']

count_wins = 0
count_loses = 0

if evnname.nil? && evncrit.nil?
  review_links.map do |link|
    printer = Printer.new(link)
    printer.print_default(evnname)
  end
elsif !evnname.nil? && evncrit.nil?
  arr_results = review_links.map do |link|
    printer = Printer.new(link)
    printer.print_evnname(evnname)
  end

  arr_results.each do |i|
    if i == 'win'
      count_wins += 1
    elsif i == 'lose'
      count_loses += 1
    end
  end
  puts
  puts "#{evnname} wins #{count_wins} times, loses #{count_loses} times."
elsif evnname.nil? && !evncrit.nil?
  review_links.map do |link|
    printer = Printer.new(link)
    printer.print_evncrit(evncrit)
  end
else
  arr_results = review_links.map do |link|
    printer = Printer.new(link)
    printer.print_evncrit_evnname(evnname, evncrit)
  end
  arr_results.each do |i|
    if i == 'win'
      count_wins += 1
    elsif i == 'lose'
      count_loses += 1
    end
  end
  puts
  puts "#{evnname} wins #{count_wins} times, loses #{count_loses} times."
end
