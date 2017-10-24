require './singer'
require './scraping_err'
require './criterion_err'

class Judge
  def initialize(song, criterion)
    @song = song
    @criterion = criterion
  end

  def result
    processed_lyrics = split_by_singers @song
    left_mc = processed_lyrics[:left_mc]
    right_mc = processed_lyrics[:right_mc]
    results = case @criterion
              when nil
                char_criterion(left_mc, right_mc)
              when 'fuck'
                fuck_criterion(left_mc, right_mc)
              else
                raise CriterionError, 'Criterion does not exists'
              end
    winner = if results[:left_mc] > results[:right_mc]
               left_mc
             elsif results[:right_mc] > results[:left_mc]
               right_mc
             end
    result = "#{@song.name} - #{@song.link}\n"
    result += "#{left_mc.name} - #{results[:left_mc]}\n"
    result += "#{right_mc.name} - #{results[:right_mc]}\n"
    result += winner.nil? ? 'Tie.' : "#{winner.name} WIN!"
    { winner: winner, statistics: result }
  end

  private

  def split_by_singers(song)
    singers = singer_names song.name
    raise ScrapingError, 'Incorrect song name' if singers.size < 2
    left_mc = Singer.new singers[0]
    right_mc = Singer.new singers[1]
    lyrics = song.lyrics.split("\n\n")
    lyrics.each do |speech|
      meta_data = speech.split("\n")[0]
      text = speech.split("\n")[1..-1].join "\n"
      left_mc.song += text if contain?(meta_data, left_mc.name)
      right_mc.song += text if contain?(meta_data, right_mc.name)
    end
    { left_mc: left_mc, right_mc: right_mc }
  end

  def char_criterion(left_mc, right_mc)
    regex = /\w/
    { left_mc: results(left_mc, regex), right_mc: results(right_mc, regex) }
  end

  def fuck_criterion(left_mc, right_mc)
    regex = /fuck|Fuck/
    { left_mc: results(left_mc, regex), right_mc: results(right_mc, regex) }
  end

  def singer_names(song_name)
    delimiter = song_name.match(/ vs. | Vs | vs /)[0] # the first coincidence
    song_name.split delimiter
  end

  def contain?(meta, name)
    meta.include? name
  end

  def results(mc, regex)
    mc.song.scan(regex).size
  end
end
