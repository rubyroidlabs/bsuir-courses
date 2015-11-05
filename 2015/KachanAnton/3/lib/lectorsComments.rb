class LectorsComments
  def initialize(names)
    @names = names
    @agent = Mechanize.new
    @url = 'http://bsuir-helper.ru/'
    @lectors_comment = Hash.new
  end

  def get_comments()
    begin
      page = @agent.get(@url + 'lectors')
    rescue => e
      puts "Cannot connect to bsuir-helper.ru: #{e.message}"
    end
    @names.each do |name|
      page.search('#content-content div div a').each do |link|
        if name == change_name(link.text)
          @lectors_comment[name] = parse_comments(link['href'])
        elsif @lectors_comment[name].nil?
          @lectors_comment[name] = Array.[]('Comments not found!')
        end
      end
    end
    @lectors_comment
  end
  
  private
  
  def change_name(name)
    surname, nm, patr = name.split
    surname + ' ' + nm[0] + '.' + ' ' + patr[0] + '.'
  end
  
  def parse_comments(name_lector)
    comments = []
    begin
      page = @agent.get(@url + "#{name_lector}")
    rescue => e
      puts "Cannot connect to bsuir-helper.ru: #{e.message}"
    end
    page.search('#comments div.rounded-outside div div').each do |com|
      message = com.search('div.content')
      date = com.search('div.submitted span.comment-date')
      comments.push(date.text + message.text)
    end
    comments
  end
end