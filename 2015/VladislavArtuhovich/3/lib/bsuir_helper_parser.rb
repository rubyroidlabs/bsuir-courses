class BsuirHelperParser
  LECTORS_URL = 'http://bsuir-helper.ru/lectors'
  HELPER_URL = 'http://bsuir-helper.ru'

  def get_teacher_url(teacher_name)
    teacher_id = get_teacher_id(teacher_name)
    if !teacher_id.nil?
      teacher_url = HELPER_URL + teacher_id
    else
      teacher_url = 'Not found'
    end
    teacher_url
  end

  def get_teacher_id(teacher_name)
    mechanize = Mechanize.new
    lector_link = nil
    lectors_page = mechanize.get(LECTORS_URL).links
    lectors_page.each do |teacher_link|
      if teacher_name == teacher_link.text
        lector_link = teacher_link.href
        break
      end
    end
    lector_link
  end

  def get_comments(teacher_name)
    comments = []
    comment_blocks = []
    mechanize = Mechanize.new
    teacher_url = get_teacher_url(teacher_name)

    if teacher_url != 'Not found'
      teacher_page = mechanize.get(teacher_url)
    else
      return -1
    end

    teacher_page.search('div.comment.clear-block').each do |comment_block|
      comment_blocks.push(comment_block)
    end

    comment_blocks.each do |comment_block|
      comment = comment_block.search('div.content p').text
      time = comment_block.search('span.comment-date').text
      comments.push("#{time}: #{comment}")
    end
    comments
  end
end
