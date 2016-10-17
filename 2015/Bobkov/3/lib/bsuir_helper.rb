class Bsuirlectors
  def initialize(fio)
    @lname, @fn, @mn = fio.split
    @feedback0 = true
  end

  def find
    agent = Mechanize.new
    goodbad = GoodOrBad.new
    page = agent.get('http://bsuir-helper.ru/lectors')
    puts "#{@lname} #{@fn} #{@mn}"
    puts '====='
    page.links.each do |link|
      lname, fn, mn = link.text.sub('ё', 'е').split
      if lname == @lname && fn[0] == @fn[0] && mn[0] == @mn[0]
        review = link.click
        rw = review.search(".//div[@class='comment odd clear-block']")
        rw1 = review.search(".//div[@class='comment even clear-block']")
        rw1.each { |temp| rw.push(temp) }
        rw.each do |review_meta|
          begin
            @feedback0 = false
            commentdate = review_meta.search('.comment-date')[0].text
            content = review_meta.search('.content')[0].text
            goodbad.know(content)
            puts commentdate
            Visualiser.new(content, goodbad.how)
          rescue
            puts 'Не найдено отзывов'
          end
        end
      end
    end
    if @feedback0 == true
      puts 'Не найдено отзывов'
    end
    puts
  end
end
