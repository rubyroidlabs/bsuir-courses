require 'mechanize'
require 'nikkou'
require 'json'

#
class Parser
  def initialize
    @agent = Mechanize.new
    @imdb_page = @agent.get('https://goo.gl/yV7Gcb')
    @listal_page = @agent.get('https://goo.gl/bqqzVx')
    @pinknews_page = @agent.get('https://goo.gl/U2AFZf')
    @data = []
    @description = nil
    @orientation = nil
    @regex = 'gay\s|lesbian\s|bisexual\s'
  end

  def parse_imdb_data
    review_links = @imdb_page.links_with(href: /nm/)
    review_links.map do |link|
      review = link.click
      biography = review.link_with(text: /See full bio/).click
      name = biography.search('h3')[0].text.strip
      meta = biography.search('div .soda').text_matches(/#{@regex}/).first
      unless meta.nil?
        description = meta.text.strip
        orientation = meta.matches[0].capitalize
      end
      celebrity_data = {
        name: name,
        description: description,
        orientation: orientation
      }
      @data << celebrity_data unless name == ''
    end
  end

  def parse_listal_data
    meta = @listal_page.search('#customlistitems')
    celebrity_name = meta.search('a').text.gsub(/[1\t\r\n]/, '').split('  ')
    celebrity_name.each do |name|
      celebrity_data = {
        name: name,
        description: @description,
        orientation: @orientation
      }
      @data << celebrity_data unless name == ''
    end
  end

  def parse_pinknews_data
    link_number = 2
    names = []
    review_meta = []
    loop do
      lien = @pinknews_page.link_with(text: link_number.to_s)
      link_number += 1
      review_meta = @pinknews_page.search('#article-main-content')
      names += review_meta.search('h2').text.gsub(/[0-9]/, '').split('. ')
      break unless lien
      @pinknews_page = lien.click
    end
    names.each do |name|
      celebrity_data = {
        name: name,
        description: @description,
        orientation: @orientation
      }
      @data << celebrity_data unless name == ''
    end
  end

  def write_data
    parse_imdb_data
    parse_listal_data
    parse_pinknews_data
    @data.uniq! { |data| data[:name] }
    File.open('./resourse/data.json', 'w') do |temp|
      temp.write(@data.to_json)
    end
  end
end
