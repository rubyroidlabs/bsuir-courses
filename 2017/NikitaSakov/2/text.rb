class Text
  def self.find_names(title, names, key)
    title = title.split(key)
    names[0] = title.first
    title[1] = title.last.split('(')
    names[1] = title.last.first
    names.last.strip!
    names
  end

  def self.count_letters(page_of_battle, names, summ_of_letters)
    text = page_of_battle.css('.lyrics p').to_s
    text = text.split('<br>')
    key = ENV['CRITERIA'].nil? ? /\w/ : ENV['CRITERIA']
    present_i = 0
    text.size.times do |i|
      if text[i].include? 'Round'
        present_i = text[i].include?(names.first) ? 0 : 1
        next
      end
      if text[i].scan(key).size < 100
        summ_of_letters[present_i] += text[i].scan(key).size
      end
    end
    summ_of_letters
  end
end
