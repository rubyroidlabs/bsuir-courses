require 'mechanize'

class ParsePages
  attr_reader :message
  attr_reader :bot
  IMDB_ACTORS = 'http://www.imdb.com/list/ls072706884/'.freeze
  h = 'http://www.newnownext.com/gay-celebrities-comi'
  NEWNOW_ACTORS = h + 'ng-out-2017/10/2017/'.freeze

  def initialize(message, bot)
    @message = message
    @bot = bot
    @actors_imdb = []
    @actors_info_imdb = []
    @actors_newnow = []
    @actors_info_newnow = []
  end

  def get_data_from_imdb(message)
    i = 0
    while i < @actors_imdb.count
      if message.text == @actors_imdb[i]
        feedback = { actor: @actors_imdb[i],
                     info: @actors_info_imdb[i] }
        feedback
        break
      end
      i += 1
    end
  end

  def get_data_from_newnow(message)
    i = 0
    while i < @actors_newnow.count
      if message.text == @actors_newnow[i]
        feedback = { actor: @actors_newnow[i],
                     info: @actors_info_newnow[i] }
        feedback
        break
      end
      i += 1
    end
  end

  def make_data_from_imdb
    page = Mechanize.new.get(IMDB_ACTORS)
    page.css('.list.detail .info b').each do |actor|
      @actors_imdb << actor.text
    end

    page.css('.list.detail .description').each do |orientation|
      @actors_info_imdb << orientation.text.split(' ')[0]
    end
  end

  def make_data_from_newnow
    page = Mechanize.new.get(NEWNOW_ACTORS)
    page.css('.heading').each do |name|
      @actors_newnow << name.text
    end
    page.css('.description-container p:first-child').each do |current_info|
      @actors_info_newnow << current_info.text
    end
  end
end
