require 'mechanize'
require 'colorize'
require 'yaml'

module LectorsProber
  class Prober
    LECTORS_INDEX_URL = 'http://bsuir-helper.ru/lectors'
    LECTOR_URL_FORMAT = 'http://bsuir-helper.ru%s'
    SCHEDULE_URL_FORMAT = 'http://www.bsuir.by/schedule/schedule.xhtml?id=%s'
    SEPARATOR = '======='.red

    def initialize(num_group)
      @num_group = num_group
      @tonality = YAML.load_file('config/default.yml')
      @agent = Mechanize.new
    end

    def find_lectors
      lectors = []
      work_page = @agent.get(format(SCHEDULE_URL_FORMAT, @num_group))
      work_page.links.each do |link|
        lectors.push(link.text[0...-4])
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
          comments = find_comments(lector_link)
          lectors_info << { name: name, comments: comments }
        end
      end
      lectors_info
    rescue
      raise 'Comment not found or unable to connect to the internet.Try again.'
    end

    def find_comments(lector_link)
      comments = []
      lector_path = lector_link.at('a/@href').value
      lector_page = @agent.get(format(LECTOR_URL_FORMAT, lector_path))
      (lector_page / 'div.comment/div.content/p').each do |comment|
        comments << analysis_tonality(comment.children.to_s).delete('<br>')
      end
      comments
    end

    def analysis_tonality(comment)
      negative = @tonality['negative']
      positive = @tonality['positive']
      count = 0
      positive.each { |word| count += 1 if comment.downcase.include? word }
      negative.each { |word| count -= 1 if comment.downcase.include? word }
      if count > 0
        comment.green
      elsif count < 0
        comment.red
      else
        comment
      end
    end

    def to_s
      lectors = find_lectors
      lectors_info = ''
      lectors.each do |lector|
        lectors_info << "#{lector[:name]}\n#{SEPARATOR}\n\n"
        lector[:comments].each { |com| lectors_info << "#{com}\n\n" }
      end
      lectors_info
    end
  end
end
