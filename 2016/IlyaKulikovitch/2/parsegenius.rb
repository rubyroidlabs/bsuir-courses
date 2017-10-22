class ParseGenius < Kodt
  def search_album
    agent = Mechanize.new
    page = agent.get('https://genius.com/artists/albums?for_artist_page=117146&amp;id=King-of-the-dot')
    review_links_albums = page.links_with(class: /album_link/)
    review_links_albums.each do |l|
      tracklist = l.click
      review_links_tracklist = tracklist.links_with(class: /u-display_block/)
      review_links_tracklist.each do |link|
        sum_odd = 0
        sum_even = 0
        review = link.click
        review_tr = review.search('.song_body-lyrics')
        artist = review_tr.search('h2')[0].text.gsub('Lyrics', '').delete('.')
        text_batle = review_tr.search('.lyrics p').text.delete('.')
        break if get_arr_words_for_pattern(text_batle).size < 7
        if artist =~ /#{@name}/
          puts artist + ' - ' + link.href
          arr_slov = get_arr_words_for_pattern(text_batle)
          get_letter_word(arr_slov, sum_odd, sum_even)
          artist_first = artist.split('vs').first.lstrip
          artist_second = artist.split('vs').at(1).lstrip.delete('.')
          info_battle(artist_first, artist_second)
          puts
          select_winner(artist_first, artist_second)
          puts
          puts
        end
      end
    end
  end

  def get_arr_words_for_pattern(text_batle, patern = /\[[^?\]]+\]/)
    text_batle.split(patern)
  end

  def get_letter_word(arr_slov, sum_odd, sum_even)
    arr_slov.each_index do |a|
      sum_odd += arr_slov[a].size if a.odd?
      sum_even += arr_slov[a].size if a.even?
      if a.odd? && @criteria
        @number_words_first += 1 if arr_slov[a] =~ /#{@criteria}/
      end
      if a.even? && @criteria
        @number_words_second += 1 if arr_slov[a] =~ /#{@criteria}/
      end
    end
    @number_letters_first = sum_odd
    @number_letters_second = sum_even
  end

  def info_battle(artist_first, artist_second)
    print artist_first
    if @criteria
      print "- #{@number_words_first} (#{@number_letters_first})"
    else print "- #{@number_letters_first}"
    end
    puts
    print artist_second
    if @criteria
      print "- #{@number_words_second} (#{@number_letters_second})"
    else print "- #{@number_letters_second}"
    end
  end

  def select_winner(artist_first, artist_second)
    if @number_words_first > @number_words_second
      print artist_first + ' WINS!'
      wins_loses(artist_first)
    elsif @number_words_first == @number_words_second
      if @number_letters_first > @number_letters_second
        print artist_first + ' WINS!'
        wins_loses(artist_first)
      else
        print artist_second + ' WINS! '
        wins_loses(artist_second)
      end
    else
      print artist_second + ' WINS!'
      wins_loses(artist_second)
    end
  end

  def wins_loses(artist_second)
    if artist_second =~ /#{@name}/
      @wins += 1 else @loses += 1
    end
  end
end
