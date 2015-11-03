require_relative 'parser'
class GroupParser < Parser
  def initialize
    super
  end

  def submit_form(group_name)
    form = @page.forms.first
    form["studentGroupTab:studentGroupForm:searchStudentGroup"] = group_name
    @page = @agent.submit(form, form.buttons.first)
  end

  def get_full_name(tutor_abbr)
    get_tutor_page(tutor_abbr)
    field_with_name = @tutor_page.search("//*[@id='employeeForm:searchEmployee_input']")
    tutor_full_name = field_with_name.map{ |node| node["value"] }.first
  end

  def view_all_tutors
    @all_tutors_abbr = @page.links.each { |link| link.text }.map(&:text).map(&:strip).uniq[3...-5]
    if @all_tutors_abbr.empty?
      puts "Group not found."
    else
      @all_tutors_abbr.each do |tutor|
        puts tutor
        sleep 0.05
      end
    end
  end
end
