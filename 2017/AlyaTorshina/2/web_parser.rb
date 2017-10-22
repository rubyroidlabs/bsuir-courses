require 'mechanize'
require_relative 'rapper'
require_relative 'restorator'

class WebParser
  attr_accessor :agent, :links, :battle

  def initialize
    @agent = Mechanize.new
    @links = []
  end

  def start
    page = @agent.get('https://genius.com/artists/King-of-the-dot')
    page = page.link_with(class: 'full_width_button').click
    11.times do |i|
      page.links.each do |link|
        if link.text.include? 'vs'
          @links.push(link)
        end
      end
      if i < 11
        page = page.link_with(class: 'next_page').click
      end
    end
    each_battle
  end

  def each_battle
    if ENV['NAME'].nil?
      @links.each do |link|
        extract(link)
      end
    else
      my_mc = Rapper.new(ENV['NAME'].downcase)
      @links.each do |link|
        if link.text.downcase.include? my_mc.name
          @battle = extract(link, my_mc)
        end
      end
      @battle.statistics
    end
  end

  def extract(link, my_mc = nil)
    page = link.click
    text = page.at('p').text
    title = page.at('h1').text
    puts "\n#{title} - #{page.uri}"
    if my_mc.nil?
      @battle = Restorator.new(text, title)
    else
      @battle = Restorator.new(text, title, my_mc)
    end
    @battle
  end
end
