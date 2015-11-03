require_relative 'parser'
class GroupParser < Parser
  def initialize
    super
  end

  def submit_form(group_name)
    form = @page.forms.first
    form_xpath = 'studentGroupTab:studentGroupForm:searchStudentGroup'
    form[form_xpath] = group_name
    @page = @agent.submit(form, form.buttons.first)
  end

  def get_full_name(tutor_abbr)
    get_tutor_page(tutor_abbr)
    input_xpath     = "//*[@id='employeeForm:searchEmployee_input']"
    field_with_name = @tutor_page.search(input_xpath)
    field_with_name.map { |node| node["value"] }.first
  end

  def view_all_tutors
    @all_tut_abbrs = @page.links.each(&:text).map(&:text).map(&:strip).uniq[3...-5]
    if @all_tut_abbrs.empty?
      puts 'Group not found.'
    else
      @all_tut_abbrs.each do |tutor|
        puts tutor
        sleep 0.05
      end
    end
  end
end
