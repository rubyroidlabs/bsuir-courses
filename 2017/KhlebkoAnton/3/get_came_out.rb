require 'mechanize'
require 'pry'
require 'json'

class ParseLgbt
  def go_and_find
    came_out_hash = {}
    agent = Mechanize.new
    page = agent.get('http://www.imdb.com/list/ls072706884/')
    selebrities = page.css('.list').css('.list_item')
    selebrities.each do |person|
      name = person.css('b').to_s[/\>([^<]\D)+/][1..30].gsub(
        '</a></b', ''
      ).downcase
      sexuality = person.css('.description').to_s[/\>\w+/][1..20]
      came_out_hash[name] = sexuality

    end
    page = agent.get(
      'http://www.newnownext.com/gay-celebrities-coming-out-2017/10/2017/'
    )
    selebrities = page.css('.listicle-container').css('li')
    selebrities.each do |person|
      name = person.css('.heading').to_s[/\>(\D)+\</].delete('<').delete(
        '>'
      ).downcase
      sexuality = 'I just know, that he/she is a part of LGBT community'
      came_out_hash[name] = sexuality
    end
    File.open('selebrities_hash.txt', 'w') { |file| file.write came_out_hash.to_json }
    puts 'LGBT database has been parsed'
  end
end
