# encoding: utf-8
# class for retriving information from web pages
class Fetcher
  include Helper
  LECT_REGEXP = /^([А-Я][А-Яа-я-]{3,30})[ ][А-Я][.][ ][А-Я][.][ ]*$/
  SCHEDULE_LINK = 'http://www.bsuir.by/schedule/schedule.xhtml?id='
  LECTORS_LINK = 'http://bsuir-helper.ru/lectors'
  COMMENT_CRITERIA = 'div.comment div.content'
  DATE_CRITERIA = 'div.comment div.submitted span.comment-date'

  def initialize(group_id)
    @group_id = group_id
    @mechanize = Mechanize.new
    @comments = {}
  end

  attr_reader :comments

  def fetch_comments
    names = retrieve_names
    names_hash = retrieve_lector_links(names)
    names_hash.each { |name, link| retrieve_comments(name, link) }
    @comments
  end

  private

  def retrieve_names
    page = link_checking(SCHEDULE_LINK + "#{@group_id}")
    names = page.parser.search('a').to_a.map do |x|
      x.content if x.content =~ LECT_REGEXP
    end
    names.uniq!.compact!
    error 'Invalid group id.' if names.nil?
    names
  end

  def retrieve_lector_links(names)
    names_hash = {}
    page = link_checking LECTORS_LINK
    names.each do |name|
      page.links_with(href: /lectors/).each do |link|
        names_hash[name] = link.uri if link.text[surname(name)]
      end
    end
    names_hash
  end

  def retrieve_comments(name, link)
    @comments[name] = []
    return if link == ''
    link = link_checking "http://bsuir-helper.ru#{link}"
    dates = []
    comments = []
    link.search(COMMENT_CRITERIA).each { |comment| comments << comment.text }
    link.search(DATE_CRITERIA).each { |date| dates << date.text }
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
