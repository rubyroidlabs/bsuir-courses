require_relative 'MainCommand.rb'
class ResetCommand < MainCommand
  def self.command(user_subjects, user_start_semester, user_end_semester, id)
    user_subjects = {}
    user_start_semester = ''
    user_end_semester = ''
    file = File.open("./users/#{id}", "w+")
    file.close
  end
end
