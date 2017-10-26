require './scraper'
require './judge'
require './scraping_err'

class Analyzer
  def initialize
    @name = ENV['NAME']
    @criterion = ENV['CRITERION']
  end

  def run
    wins_count = 0
    loses_count = 0
    KODTScraper.scrape_songs_api @name do |song|
      judge = Judge.new song, @criterion
      begin
        result = judge.result
      rescue ScrapingError
        next
      end
      puts "\n\n#{result[:statistics]}"
      winner = result[:winner]
      winner && winner.name == @name ? wins_count += 1 : loses_count += 1
    end
    return if @name.nil?
    stat = "\n#{@name} wins #{wins_count} times, loses #{loses_count} times."
    puts stat if @name
  end
end
