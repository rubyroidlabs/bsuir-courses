# user
class User
  def initialize(uid, json_data)
    @uid = uid
    @current = json_data["current"]
    @semester = json_data["semester"]
    @subjects = json_data["subjects"]
    @subjects = {} if @subjects.nil?
    @semester = {} if @semester.nil?
  end

  def handler(message, bot)
    puts "current:   " + @current.inspect
    controller(message, bot)
    return nil if @current == "reset"
    save_to_file
  end

  def controller(message, bot)
    if !@current
      @current = EntryPoint.new(bot, message).run(@subjects, @semester)
    elsif @current.include?("/subject")
      @current = SubjectBot.new(bot, message).handle(@current, @subjects)
    elsif @current.include?("/submit")
      @current = SubmitBot.new(bot, message).handle(@current, @subjects)
    elsif @current.include?("/semester")
      @current = SemesterBot.new(bot, message, @semester).handle(@current)
    end
  end

  def save_to_file
    file = File.open("UsersData/#{@uid}", "w+")
    file.write(JSON(current: @current, semester: @semester, subjects: @subjects))
    file.close
  end
end
