require 'mechanize'
class ReviewFinder
  def initialize(page)
    @page = page
    @reviews = []
    init_reviews
  end

  def init_reviews
    @page.search('div.comment').search('div.content').search('p').each do |comment|
      @reviews.push(comment)
    end
  end

  attr_accessor :reviews
end
