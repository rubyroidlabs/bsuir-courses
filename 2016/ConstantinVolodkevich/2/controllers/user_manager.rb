require './models/user'
require './commands/start_c'
require './commands/semester_c'
require './commands/reset_semester_c'
require './commands/subject_c'
require './commands/submit_c'
require './commands/status_c'
require './commands/reset_c'
require './controllers/db_helper'

class User_Manager

  attr_accessor :semester_c, :subject_c, :start_c, :submit_c, :status_c, :hash_of_users, :db_helper

  def initialize

    @db_helper = DB_Helper.new
    @hash_of_users = {}
    @start_c = Start_C.new
    @semester_c = Semester_C.new
    @reset_semester_c = Reset_Semester_C.new
    @subject_c = Subject_C.new
    @submit_c = Submit_C.new
    @status_c = Status_C.new
    @reset = Reset_C.new

  end

  def check_user(first_name, last_name, id)
    @db_helper.save_user(id, first_name, last_name)
  end

  def get_user(id)
    user = @db_helper.get_user(id)
    user
  end

  def update_steps(id)
    user =  @db_helper.get_user(id)
    user.user_status.steps_semester['set_ending_date'] = false
    user.user_status.steps_subject['save_subject'] = false
    user.user_status.steps_subject['save_labs'] = false
    user.user_status.steps_submit['check_subject'] = false
    user.user_status.steps_submit['submit_lab'] = false
    user.user_status.steps_reset['user_is_sure'] = false
    user.user_status.steps_submit['relevant_subj'] = ''
    @db_helper.update_user(id, user)
  end
  def execute_start()
    @start_c.execute_command
  end

  def execute_semester(id)
    user = @db_helper.get_user(id)

    unless user.user_status.steps_semester['got_ending_date']
    user = @semester_c.execute_command(user)
    @db_helper.update_user(id, user)
    "When semester ends?(YYYY-MM-DD)"
    else
      user.semester.time_left(user.semester.ending_date)
    end
  end

  def save_ending_date(id, text)
    user = @db_helper.get_user(id)
    user = @semester_c.save_ending_date(user, text)

    unless user.user_status.steps_semester['got_ending_date']
      "#{text} is invalid date! Try againe."
    else
      @db_helper.update_user(id, user)
      user.semester.time_left(user.semester.ending_date )
    end
  end

  def execute_reset_semester(id)
    user = @db_helper.get_user(id)
    user = @reset_semester_c.execute_command(user)
    execute_semester(id)
    @db_helper.update_user(id, user)
  end

  def execute_subject(id)
    user = @db_helper.get_user(id)
    user = @subject_c.execute_command(user)
    @db_helper.update_user(id, user)
    "What subject are you studing?"
  end

  def save_subject(id, text)
    user = @db_helper.get_user(id)
    user = @subject_c.save_subject(user, text)
    @db_helper.update_user(id, user)
    #p '='*30
    #p user.user_status.steps_subject['relevant_subj'] = text
    "How many labs you have to pass?"
  end

  def save_labs(id, text)
    user = @db_helper.get_user(id)
    user = @subject_c.save_labs(user, text)
    @db_helper.update_user(id, user)
    'OK'
  end

  def execute_submit(id)
    user = @db_helper.get_user(id)
    user = @submit_c.execute_command(user)
    @db_helper.update_user(id, user)
    @submit_c.create_subj_buttons(user)
  end

  def make_labs_list(id, text)
    user = @db_helper.get_user(id)
    user = @submit_c.mark_clb_step(user, text)
    @db_helper.update_user(id, user)
    @submit_c.create_labs_buttons(user, text)
  end

  def submit_lab(id, text)
    user = @db_helper.get_user(id)
    user = @submit_c.submit_lab(user, text)
    @db_helper.update_user(id, user)
    "Good job! May the Forse be with you"
  end

  def execute_status(id)
    user = @db_helper.get_user(id)
    user = @status_c.execute_command(user)
    @db_helper.update_user(id, user)
    user.status
  end

  def execute_reset(id)
    user = @db_helper.get_user(id)
    user = @reset.execute_command(user)
    @db_helper.update_user(id, user)
    "Are you sure that you wanna reset your data?(Y/N)"
  end

  def reset_user(first_name, last_name, id, text)
    if text.downcase == "y"
      user = User.new(first_name, last_name)
      @db_helper.update_user(id, user)
      "You data has been successfully reseted "
    else
      "You data isn't changed"
    end
  end

end
