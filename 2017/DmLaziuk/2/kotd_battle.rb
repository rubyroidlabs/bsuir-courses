require 'mechanize'

class KotdBattle
  attr_reader :title, :lyrics, :uri, :winner, :score

  def initialize(page = nil, criteria = nil)
    @title = ''
    @lyrics = ''
    @count = {}
    @winner = ''.to_sym
    @score = 0
    @criteria = criteria
    if page
      @uri = page.uri
      @title = page.title
      @title.gsub!('King of the Dot –', ' ')
      @title.gsub!('Lyrics | Genius Lyrics', ' ')
      @title.strip!
      @lyrics = page.css('.lyrics').text.strip
      # remove [?]
      @lyrics.gsub!(/\[\?\]/, ' ')
      # remove [...]
      @lyrics.gsub!(/\[\.\.\.\]/, ' ')
      @lyrics.gsub!(/\[…\]/, '')
      # remove [*text*]
      @lyrics.gsub!(/\[\*.*?\*\]/, ' ')
      battle
      guess_winner
    end
  end

  def to_s
    str = @title + ' - ' + @uri.to_s
    if @count.size > 1
      str += "\n"
      @count.each { |key, value| str += key.to_s + ' - ' + value.to_s + "\n" }
      str += @winner.to_s + ' WINS!' + "\n"
    end
    str
  end

  private

  def battle
    round = @lyrics.scan(/\[.*?\]/)
    text = @lyrics.split(/\[.*?\]/)
    text.shift
    (0...round.count).each do |i|
      performer = round[i]
      performer.tr!(/\[/, ' ')
      performer.tr!(/\]/, ' ')
      performer.strip!
      performer.gsub!(/Round\s\d\s?[:|\-|\u2013]*\s*/, ' ')
      performer.strip!
      key = performer
      if text[i]
        counter = @criteria ?\
                  text[i].scan(@criteria).count :\
                  text[i].scan(/[A-Za-z]/).count
      end
      if counter
        @count[key] = @count[key] ? @count[key] + counter : counter
      end
    end
  end

  def guess_winner
    if @count.size > 1
      @winner = @count.keys[0]
      @score = @count.values[0]
      @count.each do |key, value|
        if value > @score
          @winner = key
          @score = value
        end
      end
    end
  end
end
