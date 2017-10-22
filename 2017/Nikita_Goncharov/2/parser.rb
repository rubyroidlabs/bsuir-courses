# class for parsing KOTD
class Parser
  attr_accessor :addr
  attr_accessor :page
  attr_accessor :agent
  attr_accessor :lyrics
  attr_accessor :text
  attr_accessor :battle
  attr_accessor :scan_res
  attr_accessor :word_sum1
  attr_accessor :word_sum2
  attr_accessor :next_bunch
  def initialize
    @addr = 'https://genius.com/artists/songs?for_artist_page=117146&amp;id=King-of-the-dot'
    @agent = Mechanize.new
    @page = agent.get(addr)
    @lyrics = page.links_with(href: /lyrics/)
    @text = nil
    @battle = nil
    @word_sum1 = 0
    @word_sum2 = 0
    @next_bunch = nil
  end

  def take_text(ind)
    @battle = lyrics[ind].click
    @text = @battle.search('.lyrics').text.strip
  end

  def parse_text
    @scan_res = text.scan(/\[Round.*?\]/).to_s
    @scan_res = @scan_res.scan(/:[[\w+]*\s]*/).to_s
    @scan_res = @scan_res.scan(/[[\w+]*\s]*/).uniq
    @scan_res.delete('')
    @scan_res.delete(' ')
    @text = text.split(/\s*\[.*?\]\s*/)
    @text.delete_at(0)
  end

  def sum(arr)
    i = 0
    while i < arr.length
      @word_sum1 += arr[i]
      i += 2
    end
    i = 1
    while i < arr.length
      @word_sum2 += arr[i]
      i += 2
    end
  end

  def word_sum
    arr = []
    text.each do |round|
      arr += [round.split(/\s|\t/).length]
    end
    sum(arr)
  end

  def output(ind)
    puts "#{lyrics[ind].text.strip} - #{lyrics[ind].href}"
    puts "#{scan_res[0]}-#{@word_sum1}\n#{scan_res[1]}-#{@word_sum2}"
    put_win
  end

  def put_win
    if @word_sum1 > @word_sum2
      puts "#{scan_res[0]} WINS!"
    else
      puts "#{scan_res[1]} WINS!"
    end
  end

  def run
    while @page
      @lyrics = page.links_with(href: /lyrics/)
      run_bunch
      begin
        @page = agent.get(@page.links_with(class: 'next_page')[0].href)
      rescue StandardError
        break
      end
    end
  end

  def run_bunch
    i = 0
    while i < @lyrics.length
      take_text(i)
      parse_text
      word_sum
      output(i)
      @word_sum1 = 0
      @word_sum2 = 0
      i += 1
    end
  end
end