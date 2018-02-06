require 'mechanize'
class Checker
  attr_accessor :mc1, :mc2, :link

  def initialize(title_str, link)
    @mc1 = title_str.slice(0...title_str.index('vs')).strip
    @mc2 = title_str.slice(title_str.index('vs') + 2...title_str.size).strip
    @link = link
  end

  def text_arr_builder(id_arr, text)
    text_arr = []
    i = 0
    size = id_arr.size
    loop do
      break if size / 2 + i == size - 1
      temp = text.slice(id_arr[size / 2 + i] + 1, id_arr[i + 1])
      temp.delete(' ')
      text_arr.push(temp)
      i += 1
    end
    temp = text.slice(id_arr[size - 1] + 1, text.size - id_arr[size - 1] - 1)
    temp.delete(' ')
    text_arr.push(temp)
    text_arr
  end

  def parse_lyrics
    agent = Mechanize.new
    page = agent.get(@link)
    text = page.search('.lyrics').text.strip
    loop do
      break if text.sub!('[[?]]', '').nil?
    end
    loop do
      break if text.sub!('[?]', '').nil?
    end
    index_arr = (0...text.length).select do |i|
      text[i] == '['
    end
    index_arr += (0...text.length).select do |i|
      text[i] == ']'
    end
    index_arr = checker(index_arr)
    text_arr = text_arr_builder(index_arr, text)
    text_arr
  end

  def get_winner
    agent = Mechanize.new
    page = agent.get(@link)
    text = page.search('.lyrics').text.strip
    first_mc = text.slice(10...text.index(']'))
    text_arr = parse_lyrics
    if text_arr.empty?
      puts 'No text'
      return
    end
    hash = {}
    i = 0
    if first_mc == @mc1
      loop do
        break if i == text_arr.size - 1
        hash.store(@mc1, text_arr[i].size)
        hash.store(@mc2, text_arr[i + 1].size)
        i += 1
      end
    else
      loop do
        break if i == text_arr.size - 1
        hash.store(@mc2, text_arr[i].size)
        hash.store(@mc1, text_arr[i + 1].size)
        i += 1
      end
    end
    puts @mc1 + ' ' +  hash[@mc1].to_s + '  vs  ' + @mc2 + ' ' + hash[@mc2].to_s
    if hash[@mc1] > hash[@mc2]
      puts @mc1 + ' wins'
    else
      puts @mc2 + ' wins'
    end
  end

  def checker(index_arr)
    i = 0
    size = index_arr.size
    loop do
      break if index_arr.size / 2 + i == index_arr.size - 1
      i += 1
      if index_arr[size / 2 + i] - index_arr[i] < 5
        index_arr.delete_at(i)
        index_arr.delete_at(size / 2 + i)
      end
    end
    index_arr
  end
end
