class GetStuff
  def initialize
    @agent = Mechanize.new
    @teacher_list = []
    @full_names = []
  end

  def teachers(schedule_url)
    schedule_page = @agent.get(schedule_url)
    schedule_page.links.each { |link| @teacher_list << link.text.to_s }
    if @teacher_list.size == 7
      puts 'Error in group number'
      exit
    end
    @teacher_list[3..-6].uniq!.sort!
  end

  def full_teachers(teacher_list)
    teachers_helper = @agent.get(HELPER_URL)
    teacher_list.each do |name|
      surname, firstname, midname = name.split
      full_name = teachers_helper.link_with(text:
      %r{#{surname}\s+#{firstname[0]}[а-я]+\s+#{midname[0]}[а-я]+})
      if full_name.to_s.empty?
        puts name + ' -- Teacher not found'
      else
        @full_names << full_name.to_s
      end
    end
    @full_names
  end

  def get_comments(full_name)
    comments = []
    teachers_helper = @agent.get(HELPER_URL)
    teachers_helper.links.each do |link|
      if link.text.include?(full_name)
        comments_link = link.click
        comments_link.search('.comment').search('.content').each do |n|
          comments << n.text
        end
      end
    end
    if comments.empty?
      puts 'No comments found'
    end
    comments
  end
end
