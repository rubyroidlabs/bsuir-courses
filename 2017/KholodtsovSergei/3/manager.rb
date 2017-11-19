require_relative 'my_botinok'
require_relative 'parse_newnownext'
require_relative 'parse_imdb'

LINK_1 = 'http://www.newnownext.com/gay-celebrities'\
'-coming-out-2016/10/2016/'.freeze
LINK_2 = 'http://www.newnownext.com/gay-celebrities'\
'-coming-out-2017/10/2017/'.freeze
LINK_3 = 'https://www.buzzfeed.com/louispeitzman/celebrities'\
       '-you-might-not-know-are-bisexual?utm_term=.xvm3R4vGqa#'\
'.lwr5R3owlg'.freeze
DESCRIPTION_1 = '.description-container'.freeze
DESCRIPTION_2 = '.subbuzz__description'.freeze
PEOPLE_1 = '.heading'.freeze
PEOPLE_2 = '.js-subbuzz__title-text'.freeze

class Manager
  attr_accessor :list_celebrity

  def initialize
    @list_celebrity = []
  end

  def start
    parse_imdb
    parse_newnownext(LINK_1, DESCRIPTION_1, PEOPLE_1)
    parse_newnownext(LINK_2, DESCRIPTION_1, PEOPLE_1)
    parse_newnownext(LINK_3, DESCRIPTION_2, PEOPLE_2)
    Mybotinok.new(@list_celebrity).run_bot
  end

  def parse_imdb
    parser_imdb = Parseimdb.new
    all_description = parser_imdb.doc.css('.description')
    all_description.shift
    orientation = []
    orientation = parser_imdb.found_orientation(all_description, orientation)
    people = parser_imdb.doc.css('.info b')
    @list_celebrity = parser_imdb.found_celebrity(people, orientation)
  end

  def parse_newnownext(link, firstconst, secondconst)
    parser_nnn = Parsenewnownext.new(link)
    all_description = parser_nnn.doc.css(firstconst)
    all_description = to_array(all_description)
    people = parser_nnn.doc.css(secondconst)
    people.pop
    people = to_array(people)
    @list_celebrity = parser_nnn.found_celebrity(people,
                                                 all_description,
                                                 @list_celebrity)
  end

  def to_array(no_array)
    array = []
    no_array.each do |item|
      array << item.text.gsub(/\n|\t/, '')
    end
    array
  end
end

Manager.new.start
