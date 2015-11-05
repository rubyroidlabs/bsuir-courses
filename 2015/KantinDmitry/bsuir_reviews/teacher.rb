require 'mechanize'

# class Teacher finds comments by teacher name
class Teacher
  @@initialized = false

  attr_reader :link, :comments, :name

  def initialize(name)
    load_links unless @@initialized
    @name = name
    comments_links_get
    @comments = []
    comments_get
  end

  private

  def load_links
    @@teachers_links = Mechanize.new.get('http://bsuir-helper.ru/lectors').links
    @@initialized = true
  end

  def comments_links_get
    @@teachers_links.each do |link|
      if link.text.gsub(/ +/, ' ').tr('ё', 'е') == @name
        @link = link.href
        break
      end
    end
  end

  def comments_get
    return if @link.nil?
    page = Mechanize.new.get("http://bsuir-helper.ru#{@link}")
    comment_blocks = []
    page.search('div.comment.clear-block').each do |node|
      comment_blocks << node
    end
    comment_blocks.each do |block|
      date = block.search('span.comment-date').text
      text = block.search('div.content p').text
      @comments << "#{date} #{text}\t"
    end
  end
end
