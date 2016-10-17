require 'mechanize'

class Fetcher
  def initialize
    @agent = Mechanize.new
  end

  def find_professors(group)
    page = get_page_with_timetable_of_group(group)
    professors = get_array_of_professors(page)
    professors.uniq
  end

  def find_reviews(professor)
    reviews = []
    dates = []
    page =  get_page_with_list_of_professors
    name_of_professor = professor.split(' ')
    page.links_with(href: /lectors/).each do |link|
      name_of_variant = link.text.split(' ')
      if name_of_professor == name_of_variant
        reviews, dates = collect_information(link)
      end
    end
    [reviews, dates]
  end

  private

  def collect_information(link)
    page_with_inf = link.click
    reviews = collect_reviews(page_with_inf)
    dates = collect_dates(page_with_inf)
    [reviews, dates]
  end

  def get_page_with_list_of_professors
    @agent.get('http://bsuir-helper.ru/lectors')
  rescue StandardError => exc
    puts exc.message
    exit
  end

  def get_array_of_professors(page)
    professors = []
    page.links_with(href: /schedule/).each do |link|
      professors << find_fullname_of_professor(link)
    end
    professors
  end

  def collect_reviews(page)
    reviews = []
    page.search('div.comment div.content').each do |r|
      reviews << r.text
    end
    reviews
  end

  def collect_dates(page)
    dates = []
    page.search('div.comment div.submitted span.comment-date').each do |d|
      dates << d.text
    end
    dates
  end

  def find_fullname_of_professor(link)
    page_to_find_out_fullname = link.click
    form = page_to_find_out_fullname.form('employeeForm')
    form['employeeForm:searchEmployee_input']
  rescue StandardError => exc
    puts exc.message
    exit
  end

  def get_page_with_timetable_of_group(group)
    page = @agent.get('http://bsuir.by/schedule/schedule.xhtml')
    form = page.form('studentGroupTab:studentGroupForm')
    form['studentGroupTab:studentGroupForm:searchStudentGroup'] = group
    b = form.buttons.first
    @agent.submit(form, b)
  rescue StandardError => exc
    puts exc.message
    exit
  end
end
