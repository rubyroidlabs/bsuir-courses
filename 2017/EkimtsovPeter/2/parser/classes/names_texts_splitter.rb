require_relative '../classes/counter'

# Count conditions and output them on the screen
class NamesTextsSplitter
  def initialize(links)
    @wins_loses = { wins: 0, loses: 0 }
    @test = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
    @word = ENV['CRITERIA'] unless ENV['CRITERIA'].nil?
    @name = ENV['NAME'] unless ENV['NAME'].nil?
    @hash = links
  end

  def complete_names_links
    @hash.each do |names, link|
      @link = link
      name_text_split(names)
    end
    Console.display_wins_loses(@wins_loses)
  end

  private

  def name_text_split(names)
    page = @test.get(@link)
    @names = names.split(/( vs\.* | Vs )/)
    song_text = page.css('div.song_body-lyrics').css('p')
    @text = song_text.text.split(/\[*Round \d\]*:* [^\n]*\]*$|ROUND \d/)
    @text.delete_if { |value| value == '' }
    name_check
  end

  def name_check
    if @names.include?(@name) && @word.nil?
      Counter.new(@text, @names, @link).letters_count
      wins_loses
    elsif @names.include?(@name) && !@word.nil?
      Counter.new(@text, @names, @link).condition_counter
      wins_loses
    elsif @name.nil?
      Counter.new(@text, @names, @link).letters_count
    end
  end

  def wins_loses
    if Counter.new(@text, @names, @link).wins_loses_counter
      @wins_loses[:wins] += 1
    else
      @wins_loses[:loses] += 1
    end
  end
end
