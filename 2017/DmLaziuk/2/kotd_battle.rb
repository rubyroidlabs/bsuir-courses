require 'mechanize'

class KotdBattle
  attr_reader :title, :lyrics, :uri, :winner, :score

  def initialize(page = nil, criteria = nil)
    @title = ''
    @lyrics = ''
    @count = Hash.new
    @winner = ''
    @score = 0
    @criteria = criteria
    if page
      @uri = page.uri
      @title = page.title
      @title.gsub!('King of the Dot –', '')
      @title.gsub!('Lyrics | Genius Lyrics', '')
      @title.strip!
      @lyrics = page.css('.lyrics').text.strip
      # remove [?]
      @lyrics.gsub!(%r{\[\?\]}, '')
      # remove [...]
      @lyrics.gsub!(%r{\[\.\.\.\]}, '')
      # remove […]
      @lyrics.gsub!(%r{\[…\]}, '')
      # remove [*text*]
      @lyrics.gsub!(%r{\[\*.*?\*\]}, '')
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
    round = @lyrics.scan(%r{\[.*?\]})
    text = @lyrics.split(%r{\[.*?\]})
    text.shift
    (0...round.count).each do |i|
      performer = round[i]
      performer.gsub!(%r{\[}, '')
      performer.gsub!(%r{\]}, '')
      performer.strip!
      performer.gsub!(%r{Round\s\d\s?[:|\-|\u2013]*\s*}, '')
      if @criteria
        counter = text[i].scan(@criteria).count if text[i]
      else
        counter = text[i].scan(%r{[A-Za-z]}).count if text[i]
      end
      if @count[performer]
        @count[performer] += counter if counter
      else
        @count[performer] = counter if counter
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
