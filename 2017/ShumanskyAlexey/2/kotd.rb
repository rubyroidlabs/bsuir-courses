require './battle.rb'
require './printer.rb'
require 'mechanize'

url_page = 'https://genius.com/artists/King-of-the-dot'
links = []

agent = Mechanize.new
agent.get(url_page)
page = agent.page.link_with(text: /Show all songs by King of the Dot/).click

count_pages = 0
# Open 1, 2 and 3 page
while count_pages < 2
  links << page.links_with(href: %r{https://genius.com/King-of-the-dot})
  links.flatten!
  page = agent.page.link_with(text: /Next »/).click
  count_pages += 1
end

links.each do |link|
  links.delete(link) unless link.text.include? 'vs'
end

links.delete_at(139)

envname = ENV['NAME']
envcrit = ENV['CRITERIA']

count_wins = 0
count_loses = 0

if envname.nil? && envcrit.nil?
  links.map do |link|
    printer = Printer.new(link)
    printer.print_default(envname)
  end

elsif !envname.nil? && envcrit.nil?
  arr_results = links.map do |link|
    printer = Printer.new(link)
    printer.print_envname(envname)
  end

  arr_results.each do |i|
    if i == 'win'
      count_wins += 1
    elsif i == 'lose'
      count_loses += 1
    end
  end
  puts
  puts "#{envname} wins #{count_wins} times, loses #{count_loses} times."

elsif envname.nil? && !envcrit.nil?
  links.map do |link|
    printer = Printer.new(link)
    printer.print_envcrit(envcrit)
  end

else
  arr_results = links.map do |link|
    printer = Printer.new(link)
    printer.print_envcrit_envname(envname, envcrit)
  end

  arr_results.each do |i|
    if i == 'win'
      count_wins += 1
    elsif i == 'lose'
      count_loses += 1
    end
  end
  puts
  puts "#{envname} wins #{count_wins} times, loses #{count_loses} times."
end
