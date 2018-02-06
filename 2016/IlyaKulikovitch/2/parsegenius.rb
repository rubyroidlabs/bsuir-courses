class ParseGenius < Kodt
  COUNT_ROUND = 3
  def search_album
    agent = Mechanize.new
    page = agent.get('https://genius.com/artists/albums?for_artist_page=117146&amp;id=King-of-the-dot')
    review_links_albums = page.links_with(class: /album_link/)
    review_links_albums.each do |l|
      tracklist = l.click
      review_links_tracklist = tracklist.links_with(class: /u-display_block/)
      review_links_tracklist.each do |link|
        review = link.click
        review_tr = review.search('.song_body-lyrics')
        batl = review_tr.search('h2')[0].text.gsub('Lyrics', '').delete('.')
        text_batle = review_tr.search('.lyrics p').text.delete('.')
        break if get_arr_words_of_pattern(text_batle).size < COUNT_ROUND * 2 + 1
        exist_artist(batl, link.href, text_batle)
      end
    end
  end

  def exist_artist(batl, link, text_batle)
    if batl =~ /#{@rapper[:name]}/
      puts batl + ' - ' + link
      words = get_arr_words_of_pattern(text_batle)
      get_letter_word(words)
      artist_first = batl.split('vs').first.lstrip
      artist_second = batl.split('vs').at(1).lstrip.delete('.')
      info_battle(artist_first, artist_second)
      puts
      select_winner(artist_first, artist_second)
      puts
      puts
    end
  end

  def get_arr_words_of_pattern(text, patern = /\[[^?\]]+\]/)
    text.split(patern)
  end

  def get_letter_word(words)
    sum_odd = 0
    sum_even = 0
    words.each_index do |a|
      sum_odd += words[a].size if a.odd?
      sum_even += words[a].size if a.even?
      if a.odd? && @criteria
        @number_words_first += 1 if words[a] =~ /#{@criteria}/
      end
      if a.even? && @criteria
        @number_words_second += 1 if words[a] =~ /#{@criteria}/
      end
    end
    @rapper[:number_letters_first] = sum_odd
    @rapper[:number_letters_second] = sum_even
  end

  def info_battle(artist_first, artist_second)
    print artist_first
    if @criteria
      print "- #{@number_words_first} (#{@rapper[:number_letters_first]})"
    else print "- #{@rapper[:number_letters_first]}"
    end
    puts
    print artist_second
    if @criteria
      print "- #{@number_words_second} (#{@rapper[:number_letters_second]})"
    else print "- #{@rapper[:number_letters_second]}"
    end
  end

  def select_winner(artist_first, artist_second)
    if @number_words_first > @number_words_second
      print artist_first + ' WINS!'
      wins_loses(artist_first)
    elsif @number_words_first == @number_words_second
      if @rapper[:number_letters_first] > @rapper[:number_letters_second]
        print artist_first + ' WINS!'
        wins_loses(artist_first)
      else
        print artist_second + ' WINS!'
        wins_loses(artist_second)
      end
    else
      print artist_second + ' WINS!'
      wins_loses(artist_second)
    end
  end

  def wins_loses(artist_second)
    if artist_second =~ /#{@rapper[:name]}/
      @wins += 1 else @loses += 1
    end
  end
end
