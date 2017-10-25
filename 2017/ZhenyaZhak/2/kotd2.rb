class Kotd2
  # F_B - First Batler, S_B - Second Batler
  INCORRECT_VALUE = 2
  F_B = 0
  S_B = 1
  NAME_B = ENV['NAME'] ? ENV['NAME'].downcase : ' '
  CRITERIA_B = ENV['CRITERIA'] ? ENV['CRITERIA'].downcase : /\w/

  def self.puts_batler(count_batler, name_batler, link_uri)
    count = INCORRECT_VALUE
    if count_batler[F_B].zero? || count_batler[S_B].zero?
      return nil
    end
    if count_batler[F_B] == count_batler[S_B]
      str = 'Dead heat!!!'
    else
      x = count_batler[F_B] > count_batler[S_B] ? F_B : S_B
      str = "#{name_batler[x]} REAL NIGGA!!!"
      count = NAME_B == name_batler[x].downcase ? F_B : S_B
    end
    puts "\n#{name_batler[F_B]} vs #{name_batler[S_B]} - #{link_uri}"
    puts "#{name_batler[F_B]} - #{count_batler[F_B]}"
    puts "#{name_batler[S_B]} - #{count_batler[S_B]}\n#{str}\n"
    count
  end

  def self.length_search(txt, name_batler)
    count_batler = Array.new(2, 0)
    txt = txt.split("\n\n")
    flag = INCORRECT_VALUE
    txt.length.times do |i|
      txt[i] = txt[i].downcase
      count = txt[i].scan(CRITERIA_B).size
      # 0..30 range where the name is located
      if txt[i][0..30].include? name_batler[F_B].downcase
        count_batler[F_B] += count
        flag = F_B
        next
      end
      if txt[i][0..30].include? name_batler[S_B].downcase
        count_batler[S_B] += count
        flag = S_B
        next
      end
      # 150 is the threshold number of characters in the block
      if txt[i].scan(/\w/).size > 150
        if flag == INCORRECT_VALUE
          next
        else
          count_batler[flag] += count
        end
      end
    end
    count_batler
  end

  def self.count_function(link)
    page = link.click
    txt_link = link.text.split('(')[0].strip!
    txt_link.sub('vs.', 'vs')
    name_batler = Array.new
    name_batler[F_B] = txt_link.split('vs')[F_B].strip
    name_batler[S_B] = txt_link.split('vs')[S_B].strip
    if NAME_B != ' '
      if NAME_B != name_batler[F_B].downcase
        if NAME_B != name_batler[S_B].downcase
          return nil
        end
      end
    end
    txt = page.css('.lyrics p').text
    count_batler = Kotd2.length_search(txt, name_batler)
    count = Kotd2.puts_batler(count_batler, name_batler, link.uri)
    count
  end

  def self.link_run(page)
    w_l = Array.new(2, 0)
    loop do
      review_links = page.links_with(text: /vs/)
      threads = []
      review_links.map do |link|
        threads << Thread.new do
          count = Kotd2.count_function(link)
          if !count.nil? && count != INCORRECT_VALUE
            w_l[count] += 1
          end
        end
      end
      threads.each(&:join)
      if !page.link_with(text: /Next »/).nil?
        page = page.link_with(text: /Next »/).click
      else
        puts 'That is all'
        break
      end
    end
    if ENV['NAME']
      puts "\n#{ENV['NAME']} wins #{w_l[F_B]} times, loses #{w_l[S_B]} times"
    end
  end

  def self.start
    agent = Mechanize.new
    page = agent.get('https://genius.com/artists/King-of-the-dot')
    page = page.link_with(text: /Show all songs by King of the Dot/).click
    page
  end
end
