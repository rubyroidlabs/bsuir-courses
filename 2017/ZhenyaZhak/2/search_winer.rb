class SearchWiner
  # F_B - First Batler, S_B - Second Batler
  # START_B..FINISH_B range where the name is located
  START_B = 0
  FINISH_B = 30
  INCORRECT_VALUE = 2
  F_B = 0
  S_B = 1
  NAME_B = ENV['NAME'] ? ENV['NAME'].downcase : ' '
  CRITERIA_B = ENV['CRITERIA'] ? ENV['CRITERIA'].downcase : /\w/

  def self.puts_batler(count_batler, name_batler, link_uri)
    count = INCORRECT_VALUE
    if count_batler.any?(&:zero?)
      return INCORRECT_VALUE
    end
    if count_batler[F_B] == count_batler[S_B]
      str = 'Dead heat!!!'
    else
      x = count_batler[F_B] > count_batler[S_B] ? F_B : S_B
      str = "#{name_batler[x]} REAL NIGGA!!!"
      count = NAME_B == name_batler[x].downcase ? F_B : S_B
    end
    puts "\n#{name_batler[F_B]} vs #{name_batler[S_B]} - #{link_uri}
#{name_batler[F_B]} - #{count_batler[F_B]}
#{name_batler[S_B]} - #{count_batler[S_B]}\n#{str}\n"
    count
  end

  def self.length_search(txt, name_batler)
    count_batler = Array.new(2, 0)
    txt = txt.split("\n\n")
    flag = INCORRECT_VALUE
    txt.length.times do |i|
      txt[i] = txt[i].downcase
      count = txt[i].scan(CRITERIA_B).size
      if txt[i][START_B..FINISH_B].include? name_batler[F_B].downcase
        count_batler[F_B] += count
        flag = F_B
        next
      end
      if txt[i][START_B..FINISH_B].include? name_batler[S_B].downcase
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
    (F_B..S_B).each do |i|
      name_batler[i] = txt_link.split('vs')[i].strip
    end
    if NAME_B != ' '
      unless name_batler.map(&:downcase).any? { |i| i == NAME_B }
        return INCORRECT_VALUE
      end
    end
    txt = page.css('.lyrics p').text
    count_batler = SearchWiner.length_search(txt, name_batler)
    count = SearchWiner.puts_batler(count_batler, name_batler, link.uri)
    count
  end

  def self.link_run(page)
    w_l = Array.new(2, 0)
    loop do
      review_links = page.links_with(text: /vs/)
      threads = []
      review_links.map do |link|
        threads << Thread.new do
          count = SearchWiner.count_function(link)
          unless count == INCORRECT_VALUE
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
