require 'mechanize'
class Lecturer
  def initialize group_number
    @group_number = group_number
    @lecturers = Set.new
    @mechanize = Mechanize.new
  end

  def names
    page = @mechanize.get('http://www.bsuir.by/schedule/schedule.xhtml')
    form = page.forms.first 
    form["studentGroupTab:studentGroupForm:searchStudentGroup"] = @group_number
    page = form.submit(form.button_with("#{form.buttons[0].name}"))
    rows = page.parser.css("div [class='ui-datatable-tablewrapper'] a")
    rows.each do |row|
      @lecturers.add(row.text)
    end
    @lecturers
  end
end
