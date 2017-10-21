class ProcessText

  def self.find_names(title, names, key)
    title = title.split(key)
    names[0] = title[0]
    title[1] = title[1].split('(')
    names[1] = title[1][0]
    names[1].strip!
    names
  end

  def self.count_letters(page_of_battle, names, summ_of_letters)
    text = page_of_battle.css('.lyrics p').to_s
    text = text.split('<br>')
    if ENV['CRITERIA'].nil?
      key = /\w/
    else
      key = ENV['CRITERIA']
    end
    present_i = 0
    text.size.times do |i|
      if text[i].include? ('Round') and text[i].include? (names[0])
        present_i = 0
        next
      elsif text[i].include? ('Round') and text[i].include? (names[1])
        present_i = 1
        next
      end
      if text[i].scan(key).size < 100
        summ_of_letters[present_i] += text[i].scan(key).size
      end
    end
    summ_of_letters
  end

end
