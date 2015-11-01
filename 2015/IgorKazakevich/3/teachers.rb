BSUIR_ADDRESS = 'http://www.bsuir.by/schedule/schedule.xhtml'
BSUIR_FORM = 'studentGroupTab:studentGroupForm'
BSUIR_FIELD = 'studentGroupTab:studentGroupForm:searchStudentGroup'

class Teachers
  def initialize
    @group = Slop.parse do |s|
      s.string ' '
      s.on '-h', '--help' do
        puts "Enter the group number. For example: './bsuir-reviews 250501'"
        exit
      end
    end.arguments[0]
  end

  def connect_to_bsuir
    agent = Mechanize.new
    search_form = agent.get(BSUIR_ADDRESS).form_with(:name => BSUIR_FORM)

    search_form.field_with(:name => BSUIR_FIELD).value = @group

    agent.submit(search_form, search_form.buttons.first)
  end

  def find_teachers
    @teachers = Array.new

    connect_to_bsuir.parser.xpath('//div//td//a[@href]').each do |l|
      @teachers.push(l.text.split(' ')[0] + 
                    ' ' + l.text.split(' ')[1] + 
                    l.text.split(' ')[2])
    end
    @teachers.uniq!
  end
end
