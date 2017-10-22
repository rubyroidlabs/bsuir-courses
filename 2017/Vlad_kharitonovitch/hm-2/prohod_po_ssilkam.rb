require_relative 'job_with_rap.rb'
agent = Mechanize.new
@count_pages = 0
for i in 1..12 do
  @count_pages += 1
page = agent.get("https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot&page=#{@count_pages}&pagination=true")
array_of_links_of_songs = []
page.css('div#container.mecha--deprecated div#main ul li a.song_name.work_in_progress.song_link span.title_with_artists span.song_title').each do |el|
  array_of_links_of_songs << el.text
end
@count_links = 0
(array_of_links_of_songs.length).times do  
  @name_of_battle = array_of_links_of_songs[@count_links]
  @count_links += 1 
  @name_of_battle_for_output = array_of_links_of_songs[@count_links]
  if array_of_links_of_songs[@count_links]
    @name_of_first_raper = array_of_links_of_songs[@count_links].downcase.split('vs')[0]
    @name_of_second_raper = array_of_links_of_songs[@count_links].downcase.split('vs')[1]
  else
    @name_of_first_raper = 'Первый'
    @name_of_second_raper = 'Второй'
  end
  @name_of_battle.downcase!.gsub!(' ','-')
  if (@name_of_battle.include? '.') & (@name_of_battle.include? '/')
    @name_of_battle.gsub!('.','')
    @name_of_battle.gsub!('/','') 
  elsif (@name_of_battle.include? '.') & (@name_of_battle.include? '[') & (@name_of_battle.include? ']') & (@name_of_battle.include? '(') & (@name_of_battle.include? ')')
    @name_of_battle.gsub!('[','')
    @name_of_battle.gsub!(']','')
    @name_of_battle.gsub!(')','')
    @name_of_battle.gsub!('(','')
    @name_of_battle.gsub!('.','')
  elsif (@name_of_battle.include? '[') & (@name_of_battle.include? ']') & (@name_of_battle.include? '-+')
    @name_of_battle.gsub!('[','')
    @name_of_battle.gsub!(']','')
    @name_of_battle.gsub!('-+','')
  elsif (@name_of_battle.include? '.') & (@name_of_battle.include? ':') & (@name_of_battle.include? '#')
    @name_of_battle.gsub!('.','')
    @name_of_battle.gsub!(':','')
    @name_of_battle.gsub!('#','')   
  elsif (@name_of_battle.include? '[') & (@name_of_battle.include? ']')
    @name_of_battle.gsub!('[','')
    @name_of_battle.gsub!(']','')
  elsif (@name_of_battle.include? '(') & (@name_of_battle.include? ')') & (@name_of_battle.include? '.')
    @name_of_battle.gsub!('(','')
    @name_of_battle.gsub!(')','')
    @name_of_battle.gsub!('.','')
  elsif @name_of_battle.include? '.'
    @name_of_battle.gsub!('.','')
  elsif @name_of_battle.include? '/'
    @name_of_battle.gsub!('/','-')
  elsif @name_of_battle.include? '&'
    @name_of_battle.gsub!('&','and')
  elsif (@name_of_battle.include? '(') & (@name_of_battle.include? ')')
    @name_of_battle.gsub!('(','')
    @name_of_battle.gsub!(')','')
  elsif @name_of_battle.include? '\''
    @name_of_battle.gsub!('\'','')
  end
  if @name_of_battle == 'kid-twist-vs-madness'
    page_of_battle = agent.get("https://genius.com/Grind-time-now-kid-twist-vs-madness-lyrics")
    @link_on_page = "https://genius.com/Grind-time-now-kid-twist-vs-madness-lyrics"
  else
  page_of_battle =  agent.get("https://genius.com/King-of-the-dot-#{@name_of_battle}-lyrics")
  @link_on_page = "https://genius.com/King-of-the-dot-#{@name_of_battle}-lyrics"
  end
  rap_on_paragraph = page_of_battle.css('p').text
  @rap_on_string = rap_on_paragraph.to_json
  JSON.parse(@rap_on_string, :quirks_mode => true)
  @rap_on_string.gsub!('\n','')
  @rap_on_string.gsub!(']','')
  @rap_on_string.gsub!('.','')
  @rap_on_string.gsub!(' ','')
  @rap_on_string.gsub!(',','')
  @rap_on_string.gsub!(':','')
  @rap_on_string.gsub!('-','')
  @rap_on_string.gsub!(';','')
  @rap_on_string.gsub!(')','')
  @rap_on_string.gsub!('(','')
  @rap_on_string.gsub!('`','')
  @rap_on_string.gsub!('?','')
  @rap_on_string.gsub!('!','')
  @rap_on_string.gsub!('’','')
  @rap_on_string.gsub!('\\','')
  @rap_on_string.gsub!('/','')
  @rap_on_string.gsub!('\'','')
  @rap_on_string.gsub!('"','')
  @rap_on_string = @rap_on_string.split('[')
  start_rap = RapProcessing.new(@rap_on_string , @name_of_battle_for_output , @link_on_page , @name_of_first_raper , @name_of_second_raper)
  start_rap.winner
end
end