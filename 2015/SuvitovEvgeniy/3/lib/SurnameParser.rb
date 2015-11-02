class SurnameParser
  attr_reader :number, :list_of_surnames
  def initialize(number)
    @number = number
    @list_of_surnames = []
  end

  def parse
    agent = Mechanize.new
    page = agent.get("http://www.bsuir.by/schedule/schedule.xhtml?id=#{number}")
    page.links.each do |link|
      list_of_surnames << link.text.to_s
    end
    list_of_surnames
  rescue
    p 'No Internet'
    Kernel.abort
  end
end
