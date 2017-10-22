class Battle
  attr_accessor :arr_inf, :arr_data

  def initialize(link)
    @arr_inf = make_inf(link)
    @arr_data = get_text(link)
  end

  def make_inf(link)
    text_link = link.href
    arr_link = text_link.split('-').drop(4)
    arr_link.pop
    index = arr_link.index('vs')
    before_vs = []
    after_vs = []

    i = 0
    while i < index
      before_vs << arr_link[i].capitalize
      i += 1
    end

    j = index + 1
    while j < arr_link.size
      after_vs << arr_link[j].capitalize
      j = j += 1
    end

    before = before_vs.join(' ')
    after = after_vs.join(' ')
    str_vs = before + ' vs ' + after

    if after.include? 'Title Match'
      arr_after = after.split(' ')
      arr_after.pop
      arr_after.pop
      after = arr_after[0]
    end

    inf_battle = str_vs + ' - ' + text_link

    [inf_battle, before, after]
  end

  def get_text(link)
    before = @arr_inf[1]
    after = @arr_inf[2]

    review = link.click
    battle_text = review.search('.lyrics p').text.split('Round ')
    battle_text.shift

    mc1 = [battle_text[0], battle_text[2], battle_text[4]].flatten.join(', ')
    mc2 = [battle_text[1], battle_text[3], battle_text[5]].flatten.join(', ')

    count_letters1 = 0
    mc1.each_char do |i|
      count_letters1 += 1 if i =~ /[A-Za-z0-9]/
    end
    count_letters1 -= before.size

    count_letters2 = 0
    mc2.each_char do |i|
      count_letters2 += 1 if i =~ /[A-Za-z0-9]/
    end
    count_letters2 -= after.size

    [mc1, mc2, count_letters1, count_letters2]
  end
end
