require 'mechanize'
require_relative 'rapper'
require_relative 'restorator'

class WebParser
  attr_accessor :agent, :links, :battle, :name, :criteria, :initial_link
  PAGINATION = 12

  def initialize(initial_link, name, criteria)
    @agent = Mechanize.new
    @links = []
    @initial_link = initial_link
    @name = name
    @criteria = if criteria.nil?
                  /\w/
                else
                  criteria
                end
  end

  def start
    page = @agent.get(@initial_link)
    page = page.link_with(class: 'full_width_button').click
    PAGINATION.times do |i|
      page.links.each do |link|
        if link.text.include? 'vs'
          @links.push(link)
        end
      end
      if i < PAGINATION - 1
        page = page.link_with(class: 'next_page').click
      end
    end
    each_battle
  end

  def each_battle
    if @name.nil?
      @links.each do |link|
        extract(link)
      end
    else
      my_mc = Rapper.new(@name.downcase)
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
    @battle = if my_mc.nil?
                Restorator.new(text, title, @criteria)
              else
                Restorator.new(text, title, @criteria, my_mc)
              end
    @battle.create_rappers.lyrics.result
  end
end
