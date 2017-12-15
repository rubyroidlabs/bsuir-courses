# ConverterService
class ConverterService
  def get_price(count, type)
    coefficient = receive_coefficient
    price = count * coefficient if type == 'bitcoins'
    price = count / coefficient if type == 'bonsticks'
    price.round(2)
  end

  private

  def receive_coefficient
    Course.new(coefficient: parser_coefficient).save unless Course.exists?
    course = Course.first
    if course.updated_at.to_date == Time.now.utc.to_date
      course.coefficient
    else
      coefficient = parser_coefficient
      course.update(coefficient: coefficient)
      coefficient
    end
  end

  def parser_coefficient
    a = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
    url1 = 'https://ru.investing.com/currencies/btc-usd'
    url2 = 'https://www.nbrb.by/statistics/Rates/CurrBasket'
    bonst_byn = 15
    bitc_usd(a.get(url1)) * usd_byn(a.get(url2)) / bonst_byn
  end

  def bitc_usd(page)
    course = page.css('.pid-945629-last').children.first.text
    course.delete('.').tr(',', '.').to_f
  end

  def usd_byn(page)
    course = page.css('.stexttbl').children[3].children[2].text
    course.tr(',', '.').to_f
  end
end
