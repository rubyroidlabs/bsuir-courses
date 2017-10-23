# Count conditions and output them on the screen
class HashOutput
  def initialize(hsh_links)
    @wins_loses = { wins: 0, loses: 0 }
    @link = ''
    @hash = hsh_links
    @names = []
    @text = ''
    @test = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
    @word = ''
  end

  def hash_complete
    @hash.each do |names, link|
      @link = link
      page = @test.get(@link)
      @names = names.split(/( vs\.* | Vs )/)
      song_text = page.css('div.song_body-lyrics').css('p')
      @text = song_text.text.split(/\[*Round \d\]*:* [^\n]*\]*$|ROUND \d/)
      @text.delete_if { |value| value == '' }
      name_check
    end
  end

  def counter_ltrs
    first_ltrs = second_ltrs = 0

    @text.odd_values.each do |text_first|
      text_first.delete!(' ', '')
      first_ltrs += text_first.length
    end

    @text.even_values.each do |text_second|
      text_second.delete!(' ', '')
      second_ltrs += text_second.length
    end
    display_header(first_ltrs, second_ltrs)
    result_output(first_ltrs, second_ltrs)
  end

  def counter_cond
    first_words = second_words = 0

    @text.odd_values.each do |text_first|
      text_first.split(' ').each { |word| first_words += 1 if word == @word }
    end

    @text.even_values.each do |text_second|
      text_second.split(' ').each { |word| second_words += 1 if word == @word }
    end
    display_header(first_words, second_words)
    result_output(first_words, second_words)
  end

  def display_header(first_count, second_count)
    puts "#{@names.first} vs #{@names.last} | #{@link}"
    puts "#{@names.first} - #{first_count}"
    puts "#{@names.last} - #{second_count}"
  end

  def result_output(first_count, second_count)
    if first_count > second_count
      puts "#{@names.first} wins!"
      @winner = @names.first
    else
      puts "#{@names.last} wins!"
      @winner = @names.last
    end
    wins_loses_counter if !ENV['NAME'].nil?
    puts '--------------------'
  end

  def wins_loses_counter
    if @winner == ENV['NAME']
      @wins_loses[:wins] += 1
    else
      @wins_loses[:loses] += 1
    end
  end

  def wins_loses_output
    if !ENV['NAME'].nil?
      puts "Wins: #{@wins_loses[:wins]}"
      puts "Loses: #{@wins_loses[:loses]}"
    else
      puts 'That\'s all, folks!'
    end
  end

  def name_check
    if @names.include?(ENV['NAME']) && ENV['CRITERIA'].nil?
      counter_ltrs
    elsif @names.include?(ENV['NAME']) && !ENV['CRITERIA'].nil?
      @word = ENV['CRITERIA']
      counter_cond
    elsif ENV['NAME'].nil?
      counter_ltrs
    end
  end
end
