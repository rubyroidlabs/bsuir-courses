# encoding: utf-8
# class for retriving information from web pages
class Fetcher
  def initialize(group_id)
    @group_id = group_id
    @mechanize = Mechanize.new
    @comments = {}
    @comment_regexp = /comment (odd|even)(\scomment-by-author\s|\s)clear-block/
    @lect_regexp = /[\p{Cyrillic}]\W\s[\p{Cyrillic}]\W/
    @schedule_link = 'http://www.bsuir.by/schedule/schedule.xhtml?id='
  end

  attr_reader :surnames, :comments

  def retrieve_comments
    names = retrieve_names
    names_hash = retrieve_lector_links(names)
    names_hash.each { |name, link| fetch_comments(name, link) }
    @comments
  end

  private

  def retrieve_names
    page = link_checking(@schedule_link + "#{@group_id}")
    names = page.parser.search('a').to_a.map do |x|
      x.content if x.content =~ @lect_regexp
    end
    names = little_magic(names)
    error 'Invalid group id.' if names.nil?
    names
  end

  def surname(name)
    name.split(' ')[0]
  end

  def retrieve_lector_links(names)
    page = link_checking('http://bsuir-helper.ru/lectors')
    names_hash = {}
    names.each do |name|
      names_hash[name] = ''
      lector_tags = page.parser.search('a').to_a.select do |element|
        element.content[surname(name)]
      end
      next if lector_tags.empty?
      names_hash[name] = lector_tags[0]['href']
    end
    names_hash
  end

  def fetch_comments(name, link)
    @comments[name] = []
    return if link == ''
    retrieve_divs(link_checking("http://bsuir-helper.ru#{link}")).each do |node|
      node.children.to_a.each do |child|
        next unless look_for_comment(child)
        @comments[name] << look_for_comment(child)
      end
    end
  end

  def look_for_comment(block)
    # 'd' for date
    d = ''
    text = ''
    text = block.content if block['class'].eql? 'content'
    if block['class'].eql? 'submitted'
      block.children.each { |c| d = c.content if c['class'] == 'comment-date' }
    end
    return d + text unless empty?(text, d)
    false
  end

  def retrieve_divs(link)
    link.parser.search('div').to_a.select do |element|
      element['class'] =~ @comment_regexp
    end
  end

  def little_magic(array)
    # refused to work with negative range (-5..2), dont know why
    array.slice!(0..2)
    5.times { array.slice!(-1) }
    array.uniq!
  end

  def error(message)
    puts message
    exit
  end

  def link_checking(link)
    return if link.nil?
    begin
      @mechanize.get(link)
    rescue SocketError
      raise StandartError 'Connection problems, try later'
    end
  end

  def empty?(str1, str2)
    return true if str1.empty? && str2.empty?
    false
  end
end
