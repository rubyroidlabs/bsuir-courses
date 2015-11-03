require 'mechanize'

module LectorsProber
  class ParserSite
    LECTORS_INDEX_URL = 'http://bsuir-helper.ru/lectors'
    LECTOR_URL_FORMAT = 'http://bsuir-helper.ru%s'
    SCHEDULE_URL_FORMAT = 'http://www.bsuir.by/schedule/schedule.xhtml?id=%s'

    def initialize(num_group)
      @num_group = num_group
      @agent = Mechanize.new
    end

    def grab_lectors_info
      lectors = []
      work_page = @agent.get(format(SCHEDULE_URL_FORMAT, @num_group))
      work_page.links.each do |link|
        lectors.push(link.text[0..-5]) # take lector witout surname
      end
      lectors.uniq!
      lectors.pop(5) # contains none lectors links
      lectors.shift(3)
      find_lectors_info(lectors)
    rescue
      raise 'Group not found or unable to connect to the internet.Try again.'
    end

    def find_lectors_info(lectors)
      lectors_info = []
      work_page = @agent.get(LECTORS_INDEX_URL)
      (work_page / '.views-row').each do |lector_link|
        comments = []
        lectors.each do |lector_name|
          next unless /#{lector_name}/ =~ lector_link.text
          name = lector_link.text
          comments = grub_comments(lector_link)
          lectors_info << { name: name, comments: comments }
        end
      end
      lectors_info
    rescue
      raise 'Comment not found or unable to connect to the internet.Try again.'
    end

    def grub_comments(lector_link)
      comments = []
      lector_path = lector_link.at('a/@href').value
      lector_page = @agent.get(format(LECTOR_URL_FORMAT, lector_path))
      (lector_page / 'div.comment/div.content/p').each do |comment|
        comments << comment.children.to_s.gsub(/<br>/, '')
      end
      comments
    end
  end
end
