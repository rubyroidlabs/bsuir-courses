require 'net/http'
require 'json'

class SongUrlsManager
  attr_reader :homepage_url

  def initialize(url)
    @homepage_url = url + '/'
    @song_urls = nil
    @last_searched = ''
  end

  def songs
    if @song_urls.nil? || @last_searched != ''
      @last_searched = ''
      @song_urls = download_song_urls
    else
      @song_urls
    end
  end

  def search_songs(search_request)
    if @song_urls.nil? || @last_searched != search_request
      @last_searched = search_request
      @song_urls = download_song_urls(search_request)
    else
      @song_urls
    end
  end

  private

  def download_song_urls(search_request = '')
    # time = Time.now
    songs_urls = []
    next_page = 1
    until next_page.nil?
      request = make_request(next_page, search_request)
      response = parse_response(get_response(request))
      unless response[:status] == 200
        raise StandardError, "Response status: #{response[:status]}"
      end
      next_page = response[:next_page]
      songs_urls += response[:song_urls]
    end
    # puts (Time.now - time).to_s
    songs_urls
  end

  def make_request(page, search_request = '')
    if search_request == ''
      "songs?page=#{page}&sort=popularity"
    else
      "songs/search?page=#{page}&q=#{search_request}&sort=title"
    end
  end

  def parse_response(response)
    response = JSON.parse(response)
    status = response['meta']['status']
    return { status: status } unless status == 200
    next_page = response['response']['next_page']
    song_urls = parse_songs_urls(response['response']['songs'])
    { status: status, next_page: next_page, song_urls: song_urls }
  end

  def parse_songs_urls(songs)
    song_urls = []
    unless songs.length.nil?
      songs.length.times do |iterator|
        song_urls << songs[iterator]['url']
      end
    end
    song_urls
  end

  def get_response(request)
    url = homepage_url + request
    uri = URI(url)
    Net::HTTP.get(uri)
  end
end

