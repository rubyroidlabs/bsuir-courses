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
    if !@current
      obj = EntryPoint.new(bot, message)
      @current = obj.run(@subjects, @semester)

    elsif @current.include?("/subject")
      @current = SubjectBot.new(bot, message).handle(@current, @subjects)
    elsif @current.include?("/submit")
      @current = SubmitBot.new(bot, message).handle(@current, @subjects)
    elsif @current.include?("/semester")
      @current = SemesterBot.new(bot, message).handle(@current, @semester)
    end
    return nil if @current == "reset"

    file = File.open("UsersData/#{@uid}", "w+")
    file.write(JSON({ current: @current, semester: @semester, subjects: @subjects }))
    file.close
  end
end
