require 'rubygems'
require 'json'
require 'mechanize'

SONG_URLS = []

agent = Mechanize.new

page_number = 1
loop do
  page = agent.get("https://genius.com/api/artists/117146/songs?page=#{page_number}&sort=popularity").body
  page_json = JSON(page, :symbolize_names => true)
  page_json[:response][:songs].each do |song|
    SONG_URLS << song[:url]
  end
  page_number = page_json[:response][:next_page]
  break unless page_number
end

SONG_URLS.each do |link|
  page_save = agent.get(link)
  title = page_save.search('//div//h1//text()').to_html
  puts "#{title} (#{link})"
  puts "\n"
  left_battler_name = title.split(/\svs\.?\s/i).first
  right_battler_name = title.split(/\svs\.?\s/i).last
  result_text = page_save.search("//div[@class='lyrics']//p//text()")
                         .to_html.split(/\[.*\]/).drop(1)
  first_battler = result_text.select.with_index do |val, index|
    index.even?
  end
  second_battler = result_text.select.with_index do |val, index|
    index.odd?
  end
  left_battler_sum = first_battler.inject(0) {|c, w| c += w.length }
  right_battler_sum = second_battler.inject(0) {|c, w| c += w.length }
  puts "#{left_battler_name} - #{left_battler_sum}"
  puts "#{right_battler_name} - #{right_battler_sum}"
  puts "\n"
  if left_battler_sum < right_battler_sum
    puts "#{right_battler_name} WINS!"
  elsif right_battler_sum < left_battler_sum
    puts "#{left_battler_name} WINS!"
  else
    puts 'Tie!'
  end
end
