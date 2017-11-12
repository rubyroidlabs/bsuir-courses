require 'mechanize'
require 'json'
ADDRES = 'http://www.imdb.com/list/ls072706884/'.freeze
# class includes people of non-traditional orientation
class ArrayOfPeople
  def initialize(string)
    @string = string
  end

  def array_of_names
    names = []
    agent = Mechanize.new
    agent.get(ADDRES)
    count = agent.page.css('b').css('a').size
    count_of_people = 0
    count.times do
      names << agent.page.css('b').css('a')[count_of_people].text.downcase
      count_of_people += 1
    end
    names
  end

  def onfile
    data_json = JSON.generate(array_of_names)
    data = File.new('data.json', 'w')
    data.puts(data_json)
    data.close
  end

  def check_name
    data = File.read('data.json')
    array_of_actors = JSON.parse(data)
    array_of_actors.include?(@string)
  end

  def pin
    return 'да' if check_name
    'не найдено данных'
  end
end
