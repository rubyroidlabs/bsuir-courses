require_relative 'bsuir_helper_html_parser'
require 'colorize'
class Teacher
  attr_accessor :name, :surname, :patronymic, :department

  def get_comments!
    initials = @surname + ' '
    initials.concat(@name)
    initials += ' '
    initials.concat(@patronymic)
    @comments = BsuirHelperHtmlParser.get_teacher_comments(initials)
  end

  def show_information
    initials = @surname + @name.chars.first + '. ' + @patronymic.chars.first + '.'
    puts "\n" + initials + "\n"
    if @comments.count > 0
      @comments.each do |comment|
        if comment.positive
          print_comment(comment) { |str| print str.green }
        elsif comment.negative
          print_comment(comment) { |str|  print str.red }
        else
          print_comment(comment) { |str|  print str.yellow }
        end
      end
    else
      puts "\n Коментариев нет."
    end
    puts "\n =======".red
  end

  def print_comment(comment, &block)
    print comment.date
    block.call(' ' + comment.text + "\n")
  end
end
