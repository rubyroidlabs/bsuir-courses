require 'rubygems'
require 'mechanize'
require 'json'
class Program
  attr_accessor :hesh, :index, :first, :second, :win, :lose
  def main
    @index = 0
    @hesh = Array.new
    @url = Array.new
    @win = 0
    @lose = 0
    name = ENV['NAME']
    agent = Mechanize.new
    next_page = 1
    loop do
      request = 'https://genius.com/api/artists/117146/'
      request += if name
                   "songs/search?page=#{next_page}&q=#{name}&sort=title"
                 else
                   "songs?page=#{next_page}&sort=title"
                 end    
      respond = agent.get(request).content
      respond = JSON.parse(respond)
      song_list = respond['response']['songs'].uniq
      song_list.each do |song|
        song_page = agent.get(song['url'])
        song_text = song_page.search('.lyrics p').text
        @hesh[@index] = song_text
        @url[@index] = song['url']
        counters = counter
        names = get_names(song['title'])
        @first = names[0]
        @second = names[1]
        output(counters)
        @index += 1
      end
      next_page = respond['response']['next_page']
      break next_page
    end
    result
  end

  def get_names(title)
    names = if title.include? 'vs.'
              title.split(' vs. ')
            elsif title.include? 'Vs'
              title.split(' Vs ')
            else
              title.split(' vs ')
            end
    names
  end

  def counter
    a = @hesh[@index].scan(/\[Round [123].+\]/)
    t = if a.empty?
          @hesh[@index].split(/\[[^?\]]+\]/)
        else
          @hesh[@index].split(/\[Round [123].+\]/)
        end
    t.shift
    player = [0, 0]
    criterion = '[A-Za-z]'
    player [0] += t[0].scan(/#{criterion}/).size unless t[0].nil?
    player [1] += t[1].scan(/#{criterion}/).size unless t[1].nil?
    player [0] += t[2].scan(/#{criterion}/).size unless t[2].nil?
    player [1] += t[3].scan(/#{criterion}/).size unless t[3].nil?
    player [0] += t[4].scan(/#{criterion}/).size unless t[4].nil?
    player [1] += t[5].scan(/#{criterion}/).size unless t[5].nil?
    player
  end

  def output(player)
    puts "#{@first} vs #{@second} #{@url[index]}"
    puts "#{@first} - #{player[0]}"
    puts "#{@second} - #{player[1]}"
    if player[0] > player[1]
      puts "#{@first} WINS!"
      if @first.include? ENV['NAME']
        @win += 1
      else
        @lose += 1
      end
    else
      puts "#{@second} WINS!"
      if @first.include? ENV['NAME']
        @lose += 1
      else
        @win += 1
      end
    end
  end

  def result
    puts "#{ENV['NAME']} wins - #{@win} ,lose - #{@lose}"
  end
end
Program.new.main
