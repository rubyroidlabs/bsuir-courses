require 'mechanize'

mechanize = Mechanize.new

page = mechanize.get('https://genius.com/artists/King-of-the-dot')

array_links = []
page.links.each do |link|
  if link.text.include? 'Show all songs'
    page = mechanize.get(link.uri)

    page.links.each do |next_link|
      if next_link.text.include? 'vs'
        array_links.push(next_link.uri)
    end
      (2..12).each do |i|
        if next_link.text == "#{i}"
          page = mechanize.get(next_link.uri)
          page.links.each do |double_next_link|
            if double_next_link.text.include? 'vs'
              array_links.push(double_next_link.uri)
            end
          end
        end
        i  += 1
      end
    end
  end
end

wins_count = 0
lose_count = 0

(0..array_links.size).each do |i|
  text_page = mechanize.get(array_links[i])

  name = text_page.title
  start_interval = 'King of the Dot – '.length
  end_interval = name.index('Lyrics')

  members = name[start_interval...end_interval]
  if members.include? 'vs.'
    end_interval = members.index(' vs. ')
    first_member = members[0...end_interval]
    start_interval = first_member.length + ' vs. '.length
    second_member = members[start_interval...members.length-1]
  else
    end_interval = members.index(' vs ')
    first_member = members[0...end_interval]
    start_interval = first_member.length + ' vs '.length
    second_member = members[start_interval...members.length-1]
  end

  if second_member.include? 'Match'
    second_member = members[start_interval...members.length-15]
  end

  if ENV['NAME'].nil?

    start_interval = 'King of the Dot – '.length
    end_interval = name.index('Lyrics')
    puts "#{name[start_interval...end_interval]} - #{array_links[i]}"

    doc_text = text_page.parser
    doc = doc_text.search('body').search('p').to_s
    if doc.include? 'This battle is yet to be released'
      puts 'This battle is yet to be released\n\n'
      next
    end

    while doc.include? '<br>'
      doc.slice! '<br>'
    end
    doc.slice! '<p>'
    doc.slice! '</p>'
    while doc.include? '>'
      start_interval = doc.index('<')
      end_interval = doc.index('>')
      doc.slice! (start_interval..end_interval)
    end

    first_artist = 0
    second_artist = 0

    if doc.length < 5000
      puts 'No enogh rap text\n\n'
      next
    end

    if doc.include? 'Swave Sevah'
      doc.sub! 'SWAVE SEVAH', 'Round 1: Swave Sevah'
    end

    if first_member.include? '&' or second_member.include? '&'
      puts 'This is a double battle without winners!\n\n'
      next
    end

    first_one = "1: #{first_member[0..2]}"
    second_one = "1: #{second_member[0..2]}"
    if !doc.include? first_one or !doc.include? second_one
      puts 'No enogh artists\n\n'
      next
    end

    doc.delete! '['
    doc.delete! ']'

    first_third = "Round 3: #{first_member[0..2]}"
    second_third = "Round 3: #{second_member[0..2]}"
    if !doc .include? first_third or !doc.include? second_third
      puts 'No enough rounds\n\n'
      next
    end

    if doc.include? 'Verse'
      doc.sub! 'Verse', 'Round'
    end

    if doc.include? 'Round Two'
      doc.sub! 'Round Two', 'Round 2'
    end

    if doc.include? 'Round 2;'
      doc.sub! 'Round 2;', 'Round 2:'
    end

    if doc.include? 'The Bender'
      doc.sub! 'The Bender', 'Bender'
    end

    if i == 176
      doc.sub! 'RichPo', 'PoRich'
    end

    if doc[9..11] == first_member[0..2]
      (1..3).each do |num|
        start_interval = doc.index("Round #{num}: #{first_member[0..2]}")
        end_interval = doc.index ("Round #{num}: #{second_member[0..2]}")
        first_index = start_interval + "Round i: ".length + first_member.length
        first_artist += doc[first_index...end_interval].length
        start_interval = end_interval
        first_index = start_interval + 'Round i: '.length + second_member.length
        if num == 3
          end_interval = doc.length
        else
          end_interval = doc.index ("Round #{num + 1}: #{first_member[0..2]}")
        end
        second_artist += doc[first_index...end_interval].length
      end
    else
      (1..3).each do |num|
        start_interval = doc.index("Round #{num}: #{second_member[0..2]}")
        end_interval = doc.index ("Round #{num}: #{first_member[0..2]}")
        first_index = start_interval + 'Round i: '.length + second_member.length
        second_artist += doc[first_index...end_interval].length
        start_interval = end_interval
        first_index = start_interval + 'Round i: '.length + first_member.length
        if num == 3
          end_interval = doc.length
        else
          end_interval = doc.index ("Round #{num + 1}: #{second_member[0..2]}")
        end
        first_artist += doc[first_index...end_interval].length
      end
    end

    puts "#{first_member} - #{first_artist}"
    puts "#{second_member} - #{second_artist}"

    if first_artist > second_artist
      puts "#{first_member} WINS!"
    elsif second_artist > first_artist
      puts "#{second_member} WINS!"
    else
      puts 'Friendship WINS!'
    end

  puts '\n\n'
elsif ENV['NAME'] == first_member or ENV['NAME'] == second_member
  start_interval = 'King of the Dot – '.length
  end_interval = name.index('Lyrics')
  puts "#{name[start_interval...end_interval]} - #{array_links[i]}"

  doc_text = text_page.parser
  doc = doc_text.search('body').search('p').to_s
  if doc.include? 'This battle is yet to be released'
    puts 'This battle is yet to be released\n\n'
    next
  end

  while doc.include? '<br>'
    doc.slice! '<br>'
  end
  doc.slice! '<p>'
  doc.slice! '</p>'
  while doc.include? '>'
    start_interval = doc.index('<')
    end_interval = doc.index('>')
    doc.slice! (start_interval..end_interval)
  end

  first_artist = 0
  second_artist = 0
  first_word_count = 0
  second_word_count = 0

  if doc.length < 5000
    puts 'No enogh rap text\n\n'
    next
  end

  if doc.include? 'Swave Sevah'
    doc.sub! 'SWAVE SEVAH', 'Round 1: Swave Sevah'
  end

  if first_member.include? '&' or second_member.include? '&'
    puts 'This is a double battle without winners!\n\n'
    next
  end

  string_name_one = "1: #{first_member[0..2]}"
  string_name_two = "1: #{second_member[0..2]}"
  if !doc.include? string_name_one or !doc.include? string_name_two
    puts 'No enogh artists\n\n'
    next
  end

  doc.delete! '['
  doc.delete! ']'

  string_name_first = "Round 3: #{first_member[0..2]}"
  string_name_second = "Round 3: #{second_member[0..2]}"
  if !doc .include? string_name_first or !doc.include? string_name_second
    puts 'No enough rounds\n\n'
    next
  end

  if doc.include? 'Verse'
    doc.sub! 'Verse', 'Round'
  end

  if doc.include? 'Round Two'
    doc.sub! 'Round Two', 'Round 2'
  end

  if doc.include? 'Round 2;'
    doc.sub! 'Round 2;', 'Round 2:'
  end

  if doc.include? 'The Bender'
    doc.sub! 'The Bender', 'Bender'
  end

  if i == 176
    doc.sub! 'RichPo', 'PoRich'
  end

  if ENV['CRITERIA'].nil?
    if doc[9..11] == first_member[0..2]
      (1..3).each do |num|
        start_interval = doc.index("Round #{num}: #{first_member[0..2]}")
        end_interval = doc.index ("Round #{num}: #{second_member[0..2]}")
        first_index = start_interval + 'Round i: '.length + first_member.length
        first_artist += doc[first_index...end_interval].length
        start_interval = end_interval
        first_index = start_interval + 'Round i: '.length + second_member.length
        if num == 3
          end_interval = doc.length
        else
          end_interval = doc.index ("Round #{num + 1}: #{first_member[0..2]}")
        end
        second_artist += doc[first_index...end_interval].length
      end
    else
      (1..3).each do |num|
        start_interval = doc.index("Round #{num}: #{second_member[0..2]}")
        end_interval = doc.index ("Round #{num}: #{first_member[0..2]}")
        first_index = start_interval + 'Round i: '.length + second_member.length
        second_artist += doc[first_index...end_interval].length
        start_interval = end_interval
        first_index = start_interval + 'Round i: '.length + first_member.length
        if num == 3
          end_interval = doc.length
        else
          end_interval = doc.index ("Round #{num + 1}: #{second_member[0..2]}")
        end
        first_artist += doc[first_index...end_interval].length
      end
    end
  else
    ENV['CRITERIA'] = crit
    if doc[9..11] == first_member[0..2]
      (1..3).each do |num|
        start_interval = doc.index("Round #{num}: #{first_member[0..2]}")
        end_interval = doc.index ("Round #{num}: #{second_member[0..2]}")
        first_index = start_interval + 'Round i: '.length + first_member.length
        first_word_count += doc[first_index...end_interval].scan(crit).length
        start_interval = end_interval
        first_index = start_interval + 'Round i: '.length + second_member.length
        if num == 3
          end_interval = doc.length
        else
          end_interval = doc.index ("Round #{num + 1}: #{first_member[0..2]}")
        end
        second_word_count += doc[first_index...end_interval].scan(crit).length
      end
    else
      (1..3).each do |num|
        start_interval = doc.index("Round #{num}: #{second_member[0..2]}")
        end_interval = doc.index ("Round #{num}: #{first_member[0..2]}")
        first_index = start_interval + 'Round i: '.length + second_member.length
        second_word_count += doc[first_index...end_interval].scan(crit).length
        start_interval = end_interval
        first_index = start_interval + 'Round i: '.length + first_member.length
        if num == 3
          end_interval = doc.length
        else
          end_interval = doc.index ("Round #{num + 1}: #{second_member[0..2]}")
        end
        first_word_count += doc[first_index...end_interval].scan(crit).length
      end
    end
  end

  if ENV['CRITERIA'].nil?
    puts "#{first_member} - #{first_artist}"
    puts "#{second_member} - #{second_artist}"
    first_score = first_artist
    second_score = second_artist
  else
    puts "#{first_member} - #{first_word_count}"
    puts "#{second_member} - #{second_word_count}"
    first_score = first_word_count
    second_score = second_word_count
  end



  if first_score > second_score
    puts "#{first_member} WINS!"
  elsif second_score > first_score
    puts "#{second_member} WINS!"
  else
    puts 'Friendship WINS!'
  end

  if ENV['NAME'] == first_member
    first_descript = first_score
    second_descript = second_score
  else
    first_descript = second_score
    second_descript = first_score
  end

  if first_descript > second_descript
    wins_count += 1
  else
    lose_count += 1
  end

  puts "\n\n"
  else
    next
  end
end

if !ENV['NAME'].nil?
  puts "#{ENV['NAME']} wins #{wins_count} times and loses #{lose_count} times\n"
end
