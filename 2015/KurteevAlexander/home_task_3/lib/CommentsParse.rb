require 'colorize'
require 'open-uri'
require 'hpricot'
class CommentsParse
  def initialize
    lectors = BsuirGroup.new
    @lector_list = lectors.page_parse
    lectorsbh = BsuirHelper.new
    @lector_list_bh = lectorsbh.lectors_list
    @comment_list = []
    @user_block = []
    @comment_block = []
  end

  def parser
    @lector_list.each_with_index do | current_lector, index|
      @lector_list_bh.each_with_index do |current_lector_bh, index_bh|
        if current_lector == current_lector_bh[:name]       
          puts current_lector_bh[:name].red
          @page = open(current_lector_bh[:link])
          @hp = Hpricot(@page)
          @list_comments = @hp.search(COMMENT_BLOCK)
          @user_block = @list_comments.search(USER_BLOCK)
          @comment_block = @list_comments.search(TEXT_BLOCK)
          @user = parser_block(@user_block)
          @comment = parser_block(@comment_block)
          output(@user, @comment)
        end
      end
    end
  end

  def parser_block(block)
    @output = []
    block.each_with_index do |current, index|
      current = current.inner_text.to_s
      current = current.delete("\n")
      @output[index] = current
    end
    @output
  end

  def output(output_user, output_comment)
    output_user.each_with_index do |user, index|
      puts user.blue
      puts output_comment[index].green
    end
  end
end
