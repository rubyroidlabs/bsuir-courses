require 'rubygems'
require 'mechanize'
require 'json'
K = 4 # первые 4 элемента массива,которые надо удалить,чтобы получить имена
# class for Parse
class Parse
  def initialize(count_pages, count)
    @count_pages = count_pages
    @count = count
  end

  def parse_rap_of_text(argument)
    agent = Mechanize.new
    @rap_on_paragraphs = []
    @array_of_links_of_songs = []
    agent.get("https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot&page=#{@count_pages}&pagination=true")
    links_of_songs = agent.page.links_with(dom_class: 'song_name work_in_progress   song_link')
    if argument == 1
      links_of_songs.each { |link| @rap_on_paragraphs << link.click.css('p').text }
      return @rap_on_paragraphs
    else
      links_of_songs.each { |link| @array_of_links_of_songs << link.click.title }
      return @array_of_links_of_songs
    end
  end

  def parse_round_of_text
    @rap_on_paragraph = parse_rap_of_text(1)[@count]
    @rap_for_on_link = @rap_on_paragraph.split('[')
  end

  def parse_links_of_text(argument)
    if argument == 1
      return  parse_rap_of_text(0)[@count]
    else
      return  parse_rap_of_text(0).size
    end
  end

  def name_of_the_raper(argument)
    name = parse_links_of_text(1).gsub!(/Lyrics \| Genius Lyrics/, '').split(' ')
    name.shift(K)
    name = name.join(' ').split('vs')
    if argument == 1
      return name[0]
    else
      return name[1]
    end
  end
end
