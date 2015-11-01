require 'mechanize'

class Analizator
  def initialize
    @url = 'http://sentistrength.wlv.ac.uk/#Non-English'
  end

  def open_page_and_enter_message
    agent = Mechanize.new
    analyzer_page = agent.get(@url)
    russian_form = analyzer_page.forms[7]
    russian_form.text = @message
    result_page = agent.submit(russian_form)
    need_url = result_page.uri.to_s + '&submit=Detect+Sentiment+in+Russian'
    result_page = agent.get(need_url)
    marks = []
    marks.push(result_page.search('p').search('p').search('span.ExecutiveSummary').text.split(' ')[-1])
    marks.push(result_page.search('p').search('p').search('span.ExecutiveSummary').text.split(' ')[-5])
    marks
  end

  def analyze(message)
    @message = message
    marks = open_page_and_enter_message
    differense = marks[0].to_i + marks[1].to_i
    marks[1].to_i >= 2 ? 1 : differense
  end
end
