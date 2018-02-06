
# Class which grab link, parse it and give status of every person in list
class LinkGraber
  IMDB_URL = 'http://www.imdb.com/list/ls072706884/'.freeze
  FILE = 'orient_status.out'.freeze

  def self.url_parse
    agent = Mechanize.new
    page = agent.get(IMDB_URL)
    File.open(FILE, 'w') do |file|
      page.search("//div[@class='list detail']\
        //div[contains(@class, 'list_item')]")
          .each do |person|
        person_name = person.search('.//b//a/text()')
        orient = person.search(".//div[@class='description']/text()[1]")
        file.write "#{person_name}-#{orient}\n"
      end
    end
  end
end

LinkGraber.url_parse
