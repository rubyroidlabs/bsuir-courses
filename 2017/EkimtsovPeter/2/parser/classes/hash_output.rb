# Count letters and output them on the screen
class HashOutput
  def initialize(hsh_links)
    @link = ''
    @hash = hsh_links
    @names = []
    @text = ''
    @test = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
  end

  def hash_complete
    @hash.each do |names, link|
      @link = link
      page = @test.get(@link)
      @names = names.split(/( vs\.* | Vs )/)
      song_text = page.css('div.song_body-lyrics').css('p')
      @text = song_text.text.split(/\[*Round \d\]*:* [^\n]*\]*$|ROUND \d/)
      @text.delete_if { |value| value == '' }
      name_check(ENV['NAME'])
    end
  end

  def counter(text_arr, names_arr)
    first_ltrs = second_ltrs = 0

    text_arr.odd_values.each do |text_first|
      text_first.delete!(' ', '')
      first_ltrs += text_first.length
    end

    text_arr.even_values.each do |text_second|
      text_second.delete!(' ', '')
      second_ltrs += text_second.length
    end
    result_output(names_arr, first_ltrs, second_ltrs)
  end

  def result_output(arr_names, first_l_count, second_l_count)
    puts "#{arr_names.first} vs #{arr_names.last} | #{@link}"
    puts "#{arr_names.first} - #{first_l_count}"
    puts "#{arr_names.last} - #{second_l_count}"

    if first_l_count > second_l_count
      puts "#{arr_names.first} wins!"
    else
      puts "#{arr_names.last} wins!"
    end
    puts '--------------------'
  end

  def name_check(name)
    if @names.include?(name)
      counter(@text, @names)
    elsif ENV['NAME'].nil?
      counter(@text, @names)
    end
  end
end
