class Kotd2
  def self.count_function(link)
    name_b = ENV['NAME'] ? ENV['NAME'].downcase : ' '
    criteria_b = ENV['CRITERIA'] ? ENV['CRITERIA'].downcase : /\w/
    page = link.click
    txt_link = link.text.split('(')[0].strip!
    if txt_link.include? '&'
      return
    end
    txt_link.sub('vs.', 'vs')
    name_batler = Array.new
    name_batler[0] = txt_link.split('vs')[0].strip
    name_batler[1] = txt_link.split('vs')[1].strip
    if name_b != ' '
      if name_b != name_batler[0].downcase && name_b != name_batler[1].downcase
        return
      end
    end
    txt = page.css('.lyrics p').text
    count = 0
    count_batler = Array.new
    count_batler[0] = 0
    count_batler[1] = 0
    txt = txt.split("\n\n")
    flag = 0
    txt.length.times do |i|
      txt[i] = txt[i].downcase
      count = txt[i].scan(criteria_b).size
      if txt[i][0..30].include? name_batler[0].downcase
        count_batler[0] += count
        flag = 1
        next
      end
      if txt[i][0..30].include? name_batler[1].downcase
        count_batler[1] += count
        flag = 2
        next
      end
      if txt[i].scan(/\w/).size > 150
        if flag == 1
          count_batler[0] += count
        end
        if flag == 2
          count_batler[1] += count
        end
      end
    end
    if count_batler[0].zero? || count_batler[1].zero?
      return
    end
    if count_batler[0] == count_batler[1]
      str = 'Dead heat!!!'
    else
      x = count_batler[0] > count_batler[1] ? 0 : 1
      str = "#{name_batler[x]} REAL NIGGA!!!"
    end
    puts "\n#{name_batler[0]} vs #{name_batler[1]} - #{link.uri}"
    puts "#{name_batler[0]} - #{count_batler[0]}"
    puts "#{name_batler[1]} - #{count_batler[1]}\n#{str}\n"    
  end

  def self.link_run(page)
    loop do
      review_links = page.links_with(text: /vs/)
      threads = []
      review_links.map do |link|
        threads << Thread.new do
          Kotd2.count_function(link)
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
  end

  def self.start
    agent = Mechanize.new
    page = agent.get('https://genius.com/artists/King-of-the-dot')
    page = page.link_with(text: /Show all songs by King of the Dot/).click
    page
  end
end
