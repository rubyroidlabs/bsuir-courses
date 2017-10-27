class Battle
  attr_accessor :rappers, :rounds

  def initialize(link)
    @rappers = get_names(link)
    @rounds = get_text(link)
  end

  def get_names(link)
    text_link = link.href
    arr_link = text_link.split('-').drop(4)
    arr_link.pop
    index = arr_link.index('vs')
    left_rapper = []
    right_rapper = []

    i = 0
    while i < index
      left_rapper << arr_link[i].capitalize
      i += 1
    end

    j = index + 1
    while j < arr_link.size
      right_rapper << arr_link[j].capitalize
      j += 1
    end

    right_rapper.pop(2) if right_rapper.include? 'Title'

    left_rapper = left_rapper.join(' ')
    right_rapper = right_rapper.join(' ')
    name_battle = left_rapper + ' vs ' + right_rapper

    info_battle = name_battle + ' - ' + text_link

    [info_battle, left_rapper, right_rapper]
  end

  def get_text(link)
    review = link.click
    battle_text = review.search('.lyrics p').text.split('Round ')
    battle_text.shift

    mc1 = [battle_text[0], battle_text[2], battle_text[4]].flatten.join(', ')
    mc2 = [battle_text[1], battle_text[3], battle_text[5]].flatten.join(', ')

    count_letters1 = mc1.scan(/\w+/).join.size - @rappers[1].size
    count_letters2 = mc2.scan(/\w+/).join.size - @rappers[2].size

    [mc1, mc2, count_letters1, count_letters2]
  end
end
