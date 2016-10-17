class BsuirLectors
  BSUIR_GROUP_URL = 'http://www.bsuir.by/schedule/rest/schedule/'
  BSUIR_ALL_GROUPS_URL = 'http://www.bsuir.by/schedule/rest/studentGroup/'
  attr_reader :lectors

  def initialize(agent, group_number)
    @agent = agent
    @group_number = group_number
    @groups = get_all_groups
    id = @groups[@group_number]
    if id.nil?
      err = "class: #{self.class} | error: ArgumentError | Грруппы с таким номером не существует"
      fail ArgumentError.new(err)
    else
      @lectors = get_bsuir_lectors(id)
    end
  end

  private

  def get_all_groups
    page = @agent.get(BSUIR_ALL_GROUPS_URL)
    page.search('studentGroup').each_with_object({}) do |node, groups|
      id = node.search('id').text
      number = node.search('name').text
      groups[number] = id # приходится так делать, потому что api поиска рассписания работает с id группы
    end
  rescue SocketError => e
    if e.message == 'getaddrinfo: Name or service not known'
      err = "class: #{self.class} | error: SocketError | to get #{BSUIR_ALL_GROUPS_URL}"
      fail NameError.new(err)
    else
      fail e
    end
  end

  def get_bsuir_lectors(id)
    page = @agent.get(BSUIR_GROUP_URL + id)
    last_name_not_repeat = []
    page.search('scheduleModel').each_with_object([]) do |scheduleModel, lectors|
      scheduleModel.search('schedule').each do |schedule|
        schedule.search('employee').each do |employee|
          last_name = employee.search('lastName').text
          first_name = employee.search('firstName').text
          middle_name = employee.search('middleName').text
          unless last_name_not_repeat.include?(last_name)
            last_name_not_repeat.push(last_name)
            lectors.push(last_name + ' ' + first_name + ' ' + middle_name)
          end
        end
      end
    end
  rescue SocketError => e
    if e.message == 'getaddrinfo: Name or service not known'
      err = "class: #{self.class} | error: SocketError | to get #{BSUIR_GROUP_URL + id}"
      fail NameError.new(err)
    else
      fail e
    end
  end
end
