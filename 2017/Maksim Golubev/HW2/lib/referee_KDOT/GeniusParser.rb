require 'mechanize'
require 'json'
require 'colorize'

class GeniusParser
  ACCESS_TOKEN = 'Bearer sHBj63vrkY60lT73XLkbkfT2eAEzevTnyViGu2W6Bjlv9Z4CmNBHHd4pZIPew-Nv'
   ACCESS_TOKEN.freeze
  DEFAULT_NAME = 'King-of-the-dot'.freeze

  def initialize
    @agent = Mechanize.new
    @songs = []
    @loses = 0
    @wins = 0
  end

  def get_song_urls(name = nil)
    puts 'Please w8 referee.'.blue
    find_name = name || DEFAULT_NAME
    page_nn = 1
    loop do
      request = "https://api.genius.com/search?q=#{find_name}&per_page=20&page=#{page_nn}"
      response = @agent.get(request, [], nil, { 'Authorization' => ACCESS_TOKEN }).body
      response_json = JSON.parse(response)
      break if response_json.dig('response', 'hits').empty?
      @songs << response_json.dig('response', 'hits').map do |s|
        if /(vs | vs\.)/ =~ s['result']['title']
          if name.nil?
            s['result']
          else
            s['result'] if Regexp.new(name) =~ s['result']['title']
          end
        end
      end
      page_nn += 1
    end

    @songs.flatten!.compact!
  end

  def referee(name = nil, criteria = nil)
    get_song_urls(name)

    @songs.each do |song|
      song_text = @agent.get(song['url']).search('.lyrics p').text

      begin
        rival_res = RapParser.new(song_text, criteria).split_opponents
      rescue
        next
      end
      puts "#{song['title']} - #{song['url']}".blue
      results(rival_res, name)
    end

    puts "#{name} wins #{@wins}, loses #{@loses} times".green if !name.nil?
  end

  def results(rival_res, name)
    rival_res.each do |opponent|
      puts "#{opponent[:name]} - #{opponent[:criteria_count]}".green
    end

    opponent_num = if !name.nil?
                     Regexp.new(name) =~ rival_res[0][:name] ? 0 : 1
                   end

    result_score(rival_res, opponent_num)

    puts
  end

  def result_score(rival_res, opponent = nil)
    if rival_res[0][:criteria_count] > rival_res[1][:criteria_count]
      @wins += 1 if opponent == 0
      @loses += 1 if opponent == 1

      puts "#{rival_res[0][:name]} - WINS!".red
    else
      @wins += 1 if opponent == 1
      @loses += 1 if opponent == 0

      puts "#{rival_res[1][:name]} - WINS!".red
    end
  end
end
