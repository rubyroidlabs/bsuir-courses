require_relative 'new_job_with_rap.rb'
@count_pages = 0
PAGES = 12 # кол-во страниц
PAGES.times do
  @count_pages += 1
  @count = 0
  size_of_the_array = Parse.new(@count_pages, @count)
  size_of_the_array.parse_links_of_text(0).times do
    result = RapProcessing.new(@count_pages, @count)
    result.winner
    @count += 1
  end
end
