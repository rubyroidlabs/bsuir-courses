require 'mechanize'

class KotdBattle
  attr_reader :title, :lyrics, :uri, :winners, :score

  def initialize(page = nil, criteria = nil)
    @title = ''
    @lyrics = ''
    @count = {}
    @winners = []
    @score = 0
    @criteria = criteria
    return if page.nil?
    init_by_page(page)
    battle
    guess_winner
  end

  def to_s
    str = @title.to_s + ' - ' + @uri.to_s
    if @count
      str += "\n"
      @count.each { |key, value| str += key.to_s + ' - ' + value.to_s + "\n" }
      str += @winners.join(' and ').to_s + ' WINS!' + "\n"
    end
    str
  end

  private

  def init_by_page(page)
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
    @lyrics.gsub!(/\[…\]/, ' ')
    # remove [*text*]
    @lyrics.gsub!(/\[\*.*?\*\]/, ' ')
  end

  def battle
    round = @lyrics.scan(/\[.*?\]/)
    text = @lyrics.split(/\[.*?\]/)
    text.shift # first element is always "" (zero string)
    (0...round.count).each do |i|
      performer = round[i][1...-1]
      performer.gsub!(/Round\s\d\s?[:|\-|\u2013]*\s*/, ' ')
      performer.strip!
      key = performer.to_sym
      if text[i]
        t = text[i] # duct tape to avoid rubocop "line is too long"
        counter = @criteria ? t.scan(@criteria).count : t.scan(/[A-Za-z]/).count
      end
      if counter
        @count[key] = @count[key] ? @count[key] + counter : counter
      end
    end
  end

  def guess_winner
    return if @count.empty?
    @score = @count.values.max
    @count.each { |key, value| @winners << key if value == @score }
  end
end
