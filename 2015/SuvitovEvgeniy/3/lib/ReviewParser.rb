class ReviewParser
  attr_reader :surname, :first_letter_name, :first_letter_patron
  def initialize(string)
    @surname = string.split[0] + ' '
    @first_letter_name = string.split[1][0]
    @first_letter_patron = string.split[2][0]
    @reviews = []
    @dates = []
  end

  def parse
    agent = Mechanize.new
    @@page ||= agent.get('http://bsuir-helper.ru/lectors')
    @@page.links.each do |link|
      next if !link.text.include?(@surname) ||
              !link.text.split[1].include?(first_letter_name) ||
              !link.text.split[2].include?(first_letter_patron)
      page1 = link.click
      page1.search('div.clear-block').each do |x|
        @dates << x.search('span.comment-date').text
        @reviews << x.search('div.content p').text
      end
    end
    [@reviews, @dates]
  end
end
