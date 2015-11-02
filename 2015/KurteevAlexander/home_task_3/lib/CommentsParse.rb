require 'mechanize'
require 'colorize'
require 'yaml'
require 'open-uri'
class CommentsParse
  def initialize
    lectors = BsuirGroup.new
    @lector_list = lectors.page_parse
    lectorsbh = BsuirHelper.new
    @lector_list_bh = lectorsbh.lectors_list
    @comments = []
    @time = []
  end

  def searchinfo(page, search_param)
    result_array = []
    page.search(search_param).each_with_index do |current, ind|
      current = current.text.delete("\n")
      result_array[ind] = current
    end
    result_array
  end

  def parser
    @lector_list.each do | current_lector |
      @lector_list_bh.each do |current_lector_bh |
        if current_lector == current_lector_bh[:name]
          puts current_lector_bh[:name].colorize(:blue)
          @agent = Mechanize.new
          @page = @agent.get(current_lector_bh[:link])
          pros = @page.search(COMMENT_BLOCK)
          @time = searchinfo(pros, COMMENT_TIME)
          @comments = searchinfo(pros, COMMENT_TEXT)
          unless @time.empty?
            @comments.each_with_index do |current_comment, index|
              @result_color = parsetestfile(current_comment)
              output(@time[index], current_comment, @result_color)
            end
          else
            puts 'Не найдено отзывов'
          end
        end
      end
    end
  end

  def parsetestfile(comment)
    file = YAML.load_file('test.yml')
    @result_counter = emotioncounter(comment, file, POSITIVE) - emotioncounter(comment, file, NEGATIVE)
    @result_counter
  end

  def emotioncounter(comment, word, tone)
    @counter = 0
    word[tone].each do |current_tone|
      if comment.match(current_tone)
        @counter += 1
      end
    end
    @counter
  end

  def output(output_time, output_comment, result_color)
    if result_color > 0
      puts output_time.colorize(:green) + output_comment.colorize(:green)
    elsif result_color < 0
      puts output_time.colorize(:red) + output_comment.colorize(:red)
    else
      puts output_time.colorize(:white) + output_comment.colorize(:white)
    end
  end
end
