require 'mechanize'

class Fetcher
  def initialize
    @agent = Mechanize.new
  end

  def find_professors(group)
    professors = []
    begin
      page = @agent.get('http://bsuir.by/schedule/schedule.xhtml')
      form = page.form('studentGroupTab:studentGroupForm')
      form['studentGroupTab:studentGroupForm:searchStudentGroup'] = group
      b = form.buttons.first
      new_page = @agent.submit(form, b)
      new_page.links_with(:href => /schedule/).each do |link|
        page_to_find_out_fullname = link.click
        f = page_to_find_out_fullname.form('employeeForm')
        fullname = f['employeeForm:searchEmployee_input']
        professors << fullname
      end
    rescue StandardError => exc
      puts exc.message
      exit
    end
    professors.uniq
  end

  def find_reviews(professor, reviews, dates)
    if professor == nil
      return
    end
    begin
      page = @agent.get('http://bsuir-helper.ru/lectors');
      page.links_with(:href => /lectors/).each do |link|
        name_of_professor = professor.split(' ')
        name_of_variant = link.text.split(' ')
        if name_of_professor == name_of_variant
          page_with_inf = link.click
          page_with_inf.search('div.comment div.content').each do |r|
            reviews << r.text
          end
          page_with_inf.
              search('div.comment div.submitted span.comment-date').each do |d|
            dates << d.text
          end
        end
      end
    rescue StandardError => exc
      puts exc.message
      exit
    end
  end
end
