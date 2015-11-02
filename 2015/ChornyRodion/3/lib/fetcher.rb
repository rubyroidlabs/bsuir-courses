# encoding: utf-8
# class for retriving information from web pages
class Fetcher
  include Helper

  def initialize(group_id)
    @group_id = group_id
    @mechanize = Mechanize.new
    @comments = {}
    @comment_regexp = /comment (odd|even)(\scomment-by-author\s|\s)clear-block/
    @lect_regexp = /[\p{Cyrillic}]\W\s[\p{Cyrillic}]\W/
    @schedule_link = 'http://www.bsuir.by/schedule/schedule.xhtml?id='
  end

  attr_reader :comments

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

  def retrieve_lector_links(names)
    names_hash = {}
    page = link_checking 'http://bsuir-helper.ru/lectors'
    names.each do |name|
      page.links_with(href: /lectors/).each do |link|
        names_hash[name] = link.uri if link.text[surname(name)]
      end
    end
    names_hash
  end

  def fetch_comments(name, link)
    @comments[name] = []
    return if link == ''
    link = link_checking "http://bsuir-helper.ru#{link}"
    dates = []
    comments = []
    link.search('div.comment div.content').each do |comment|
      comments << comment.text
    end
    link.search('div.comment div.submitted span.comment-date').each do |date|
      dates << date.text
    end
    comments = merge_elements dates, comments
    @comments[name] = comments
  end

  def link_checking(link)
    return if link.nil?
    begin
      @mechanize.get(link)
    rescue SocketError
      raise StandartError 'Connection problems, try later'
    end
  end
end
