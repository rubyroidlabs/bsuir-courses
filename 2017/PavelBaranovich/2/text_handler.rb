require 'mechanize'

class TextHandler
  attr_writer :name, :criteria

  def initialize(battles_links, left_mc_name, right_mc_name)
    @battles_links = battles_links
    @left_mc_name = left_mc_name
    @right_mc_name = right_mc_name
    @name = ''
    @criteria = ''
    @wins = 0
    @loses = 0
  end

  def print_title(pos)
    print "#{@left_mc_name[pos]} vs #{@right_mc_name[pos]} - "
    puts @battles_links[pos]
  end

  def get_char_count(pos)
    agent = Mechanize.new

    page_text = agent.get(@battles_links[pos]).search('div.lyrics').text
    rounds_text = page_text.split(/Round [1-3]:? /)

    count = [0, 0]
    6.times do |i|
      count[i & 1] += rounds_text[i + 1].to_s.scan(/#{@criteria}/).size
    end

    if rounds_text[1].to_s.index(@right_mc_name[pos].to_s) == 0
      count[0], count[1] = count[1], count[0]
    end

    count
  end

  def print_answer(pos)
    print "\n"

    char_count = get_char_count(pos)
    print_title(pos)

    puts "#{@left_mc_name[pos]} - #{char_count[0]}"
    puts "#{@right_mc_name[pos]} - #{char_count[1]}"

    if char_count[0] >= char_count[1]
      puts "#{@left_mc_name[pos]} WINS!"
      @wins += 1
    else
      @loses += 1
      puts "#{@right_mc_name[pos]} WINS!"
    end
  end

  def get_answer
    @criteria = if @criteria.nil?
                  "[^(.,!? ':();\n)]"
                else
                  com = "(\n| |!|.)"
                  [com, @criteria, com].join
                end

    if @name.nil?
      @battles_links.count.times do |i|
        print_answer(i)
      end
    else
      @battles_links.count.times do |i|
        if @left_mc_name[i] == @name || @right_mc_name[i] == @name
          print_answer(i)
        end
      end

      puts "\n#{@name} wins #{@wins} times, loses #{@loses} times"
    end
  end
end
