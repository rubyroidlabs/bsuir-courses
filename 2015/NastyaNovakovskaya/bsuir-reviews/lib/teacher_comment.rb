require_relative 'comment_analyzer'
class TeacherComment

  attr_accessor :positive, :negative, :text, :date

  def initialize
    @positive = false
    @negative = false
    @text = ''
    @date = ''
  end
  def set_mood
    case CommentAnalyzer.check_comment(@text)
      when 1
        @positive = true
      when 2
        @negative = true
    end
  end
end
