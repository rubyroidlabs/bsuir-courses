# coding: utf-8
require "yaml"
require "colorize"
require "unicode"

class Group
  attr_accessor :num_of_group, :opinions_about_lectors, :lectors,
                :schedule_page, :lectors_of_group_from_helper
  attr_reader :config, :schedule_link
  def initialize(number)
    @num_of_group = number
    @schedule_link = "http://www.bsuir.by/schedule/schedule.xhtml?id=#{@num_of_group}"
    @lectors_of_group_from_helper = {}
    @opinions_about_lectors = {}
    @config = YAML.load(open("../task_3/lib/opinions.yml"))
  end

  def get_all_lectors
    @lectors = @schedule_page.css("tr.ui-widget-content").map { |el| el.children[5].children.text }.uniq.select { |str| str.present? }
  end

  def get_lectors_from_helper(all_lectors)
    @lectors.each do |lector|
      all_lectors.each do |key, value|
        if (key == lector)
          @lectors_of_group_from_helper[key] = value
        end
      end
    end
  end

  def get_opinions
    downloader = Downloader.new
    @lectors_of_group_from_helper.each do |key, value|
      page = downloader.get_page_nokogiri("http://bsuir-helper.ru/#{value.href}")
      comments = {}
      text = page.css("div.rounded-outside div.comment p").map { |el| el.children.text }
      date = page.css("div.rounded-outside div.comment div.submitted span.comment-date").map { |el| el.children.text }
      date.zip(text) { |a, b| comments[a.to_sym] = b }
      @opinions_about_lectors[key] = comments
    end
  end

  def print_opinions
    @lectors.each do |lector|
      unless @opinions_about_lectors.keys.include?(lector)
        @opinions_about_lectors[lector] = []
      end
    end
    @opinions_about_lectors.each do |key, value|
      puts key
      puts "Не найдено отзывов" if value.empty?
      value.each do |date, text|
        puts "#{date} -- #{text.colorize(check_opinion(text))}"
        puts ""
      end
      puts "_______________________________________________________________________________________________________"
      puts ""
    end
  end

  def check_opinion(opinion)
    count = 0
    comment_downcase = []
    comment_downcase = Unicode.downcase(opinion)
    @config["positive"].each { |word| count += 1 if comment_downcase.include? word }
    @config["negative"].each { |word| count -= 1 if comment_downcase.include? word }
    return :red if count < 0
    return :green if count > 0
    :white
  end
end
