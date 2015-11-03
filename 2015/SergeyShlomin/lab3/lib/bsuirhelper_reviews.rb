class BsuirhelperReviews
  BSUIR_HELPER_ALL_LECTORS_URL = 'http://bsuir-helper.ru/lectors'
  BSUIR_HELPER_LECTOR_LINK_URL = 'http://bsuir-helper.ru/'
  LINK_TO_LECTOR = /\/lectors\//
  FIND_DOUBLE_SPACES = /[\s]{2,}/
  attr_reader :lector_reviews

  def initialize(agent, group_lectors)
    @agent = agent
    lectors_from_helper = get_helper_lectors
    @lector_reviews = get_lector_reviews(group_lectors, lectors_from_helper)
  end

  private

  def get_helper_lectors
    page = Mechanize.new.get(BSUIR_HELPER_ALL_LECTORS_URL)
    lector_links = page.links_with(href: LINK_TO_LECTOR)
    lector_links.each_with_object({}) do |link, lectors_helper|
      lector_fio = link.text.gsub(FIND_DOUBLE_SPACES, ' ')
      lector_link = link.uri
      lectors_helper[lector_fio] = lector_link
    end
  rescue SocketError => e
    if e.message == 'getaddrinfo: Name or service not known'
      err = "class: #{self.class} | error: SocketError | to get #{BSUIR_HELPER_ALL_LECTORS_URL}"
      fail NameError.new(err)
    else
      fail e
    end
  end

  def get_lector_reviews(group_lectors, lectors_helper)
    group_lectors.each_with_object({}) do |group_lector, lector_reviews|
      unless lectors_helper[group_lector].nil?
        # p "#{group_lector} #{lectors_helper[group_lector]}"
        page = @agent.get(BSUIR_HELPER_LECTOR_LINK_URL + lectors_helper[group_lector].to_s)
        comments_block = page.search('div#comments').search('div.comment')
        reviews = []
        comments_block.each do |comment|
          comment_date = comment.search('.comment-date').text
          comment_text = comment.search('.content p').text
          review = Review.new(comment_date, comment_text)
          reviews << review
        end
        lector_reviews[group_lector] = reviews
      end
    end
  rescue SocketError => e
    if e.message == 'getaddrinfo: Name or service not known'
      err = "class: #{self.class} | error: SocketError | to get #{BSUIR_HELPER_LECTOR_LINK_URL + lectors_helper[group_lector].to_s}"
      fail NameError.new(err)
    else
      fail e
    end
  end
end

class Review
  attr_reader :review, :date

  def initialize(date, review)
    @date = date
    @review = review
  end
end
