require 'rubygems'
require 'mechanize'
require 'pry'


class Task
  def initialize
    @agent = Mechanize.new
  end

  def parse(artist = '')
    @agent.get('https://genius.com/artists/King-of-the-dot')
    page = @agent.page.link_with(text: /Show all songs by King of the Dot/).click
    loop do
      links = []
      page.links.each do |link|
        links.push(link) if link.text.split(' ').include?('vs')
      end
      links.each do |link|
        txt = @agent.get(link.href).search('.song_body-lyrics').text.split("\n")
        name = txt[2].split(' Lyrics')
        name = name.first.split('        ')
        names = name.last
        name = name.last.split(' vs ')
        if name.include?(artist)
          print(scan(txt, name), names, link)
        elsif artist == ''
          print(scan(txt, name), names, link)
        end
      end
      page.links.each do |link|
        links = link if link.text.split(' ').include?('Next')
      end
      break if links.class.to_s != 'Mechanize::Page::Link'
      page = links.click
    end
  end

  def print(battle, name, link)
    puts "#{name} - #{link.href}"
    battle = battle.sort_by(&:last)
    puts battle.last.first + ' WINS!'
    puts
  end

  def scan(text, name)
    key = ''
    results = Hash.new(0)
    text.each do |line|
      if line.include?('[Round') && line.include?(name.first + ']')
        key = name.first
      elsif line.include?('[Round') && line.include?(name.last + ']')
        key = name.last
      end
    end
    
  end
end
ENV['NAME'] = '' if ENV['NAME'].nil?
Task.new.parse(ENV['NAME'])