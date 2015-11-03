require 'curb'
require 'mechanize'
require_relative 'teacher_comment'
class BsuirHelperHtmlParser


  def self.get_teacher_comments(initials)
    comments = Array.new
    if teacher_exist?(initials)
      teacher_link = get_teacher_link(initials)
      agent = Mechanize.new

      begin
        page = agent.get('http://bsuir-helper.ru'.concat(teacher_link))
      rescue Curl::Err::HostResolutionError
        fail 'Нет подключения к интернету'
      end
      odd_elements = page.search(".//div[@class='comment odd clear-block']")
      even_elements = page.search(".//div[@class='comment even clear-block']")

      comment_elements = odd_elements + even_elements
      comment_elements.children.each do |comment_element|
        comments.push(parse_comment_element(comment_element))
      end
    end
    comments

  end

private

  def self.parse_comment_element(comment_element)
    comment = TeacherComment.new
    comment_element.attributes.each do |a_name, a_value|
      if a_name == 'class'
        case a_value.to_s
          when 'submitted'
            comment.date = parse_comment_time(comment_element).to_s
          when 'content'
            text = self.parse_comment_text(comment_element)
            comment.text = parse_comment_text(comment_element).to_s
          else
            next
        end
      end
    end
    comment.set_mood
    comment
  end

  def self.parse_comment_time(submitted_element)
    submitted_element.children.each do |child|
      if child.name == 'span'
        child.attributes.each do |a_name, a_value|
          if a_name.to_s == 'class' && a_value.to_s == 'comment-date'
            return child.text
          end
        end
      end
    end
  end

  def self.parse_comment_text(content_element)
    content_element.children.each do |child|
      if child.name == 'p'
        return child.text
      end
    end
  end

  def self.teacher_exist?(initials)
    agent = Mechanize.new
    page = agent.get('http://bsuir-helper.ru/lectors')
    element = page.at("*[text()*='#{initials}']")

    !element.nil?
  end

  def self.get_teacher_link(initials)
    agent = Mechanize.new
    page = agent.get('http://bsuir-helper.ru/lectors')
    element = page.at("*[text()*='#{initials}']")

    teacher_link = 'lectors'
    element.attributes.each do |a_name, a_value|
      if a_name == 'href'
        teacher_link = a_value
      end
    end

    teacher_link
  end


end
