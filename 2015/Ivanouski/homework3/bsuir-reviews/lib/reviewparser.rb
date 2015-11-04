class ReviewParser
  def initialize(lectors)
    agent = Mechanize.new
    @page = agent.get('http://bsuir-helper.ru/lectors')
    @lectors = lectors
    @linklist = {}
    @review_db = []
  end

  def search_reviews
    @lectors.each do |lector|
      @lector = lector
      @linklist["#{@lector}"] = nil
      @fio = @lector.scan(/[[:word:]]+/)
      @page.links_with(text: /#{@fio[0]}?/).each do |link|
        fio_found = link.text.scan(/[[:word:]]+/)
        if fio_found[1][0] == @fio[1] && fio_found[2][0] == @fio[2]
          @linklist["#{@lector}"] = link
        end
      end
    end
    @linklist
  end

  def get_reviews
    @linklist.each_pair do |lector, link|
      @comments = []
      @dates = []
      if !link.nil?
        review = link.click
        review_meta = review.search('#comments .content')
        review_meta.each do |comment|
          @comments.push(comment.text.strip)
        end
        review_date = review.search('#comments .comment-date')
        review_date.each do |comment_date|
          @dates.push(comment_date.text.strip)
        end
      else
        @comments.push
        @dates.push
      end
      @review_db.push(lector: lector, dates: @dates, comments: @comments,)
    end
    @review_db = JSON.parse(JSON.pretty_generate(@review_db))
  end
end
