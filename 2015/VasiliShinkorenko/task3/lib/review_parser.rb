require_relative 'parser'
class ReviewParser < Parser
  def initialize
    @reviews = []
    super
  end

  def get_reviews(group_tutor)
    if link_present?(group_tutor)
      get_tutor_page(group_tutor)
      @tutor_page.search('#comments > div.rounded-outside > div > div.comment > div.content').each do |p|
        @reviews << p.text.strip
      end
    else
      @reviews << "Нет отзывов."
    end
    @reviews
  end
end
