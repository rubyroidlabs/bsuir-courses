class Rapper
  def initialize(mc_left, mc_right, link)
    @link = link
    @mc_left = mc_left
    @mc_right = mc_right
  end

  def get_letter_count(pos)
    agent = Mechanize.new
    page = agent.get(@link[pos])
    class_css = '.lyrics'
    text_of_battle = page.search(class_css).text
    text = text_of_battle.split(/Round [1-3]/)

    count = []
    count[0] = 0
    count[1] = 0
    6.times do |i|
      if i.odd?
        count[0] += text[i + 1].to_s.size
      else
        count[1] += text[i + 1].to_s.size
      end
    end

    if text[1].to_s =~ /^#{@mc_right[pos]}/
      count[0], count[1] = count[1], count[0]
    end

    count
  end

  def print_answer(pos)
    print "\n"

    letter_count = get_letter_count(pos)
    puts "#{@mc_left[pos]}  vs  #{@mc_right[pos]}   -   #{@link[pos]}"

    puts "#{@mc_left[pos]} - #{letter_count[0]}"
    puts "#{@mc_right[pos]} - #{letter_count[1]}"

    if letter_count[0] >= letter_count[1]
      puts "#{@mc_left[pos]} WINS!"
    else
      puts "#{@mc_right[pos]} WINS!"
    end
  end

  def get_answer
    @link.count.times do |i|
      print_answer(i)
    end
  end
end
