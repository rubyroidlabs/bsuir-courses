class GetName
  def initialize(number)
    @number = number
  end

  def fio
    agent = Mechanize.new
    page = agent.get("http://www.bsuir.by/schedule/schedule.xhtml?id=#{@number}")
    allname = []
    page.links.each do |link|
      if link.text =~ /[А-Я][а-я]+\s[А-Я]\.\s[А-Я]\./
        allname.push(link.text)
      end
    end
    if allname.empty?
      puts 'Check your number of group'
      exit
    end
    allname.uniq!
    allname
  rescue SocketError
    puts 'Check your internet connection'
    exit
  end
end
