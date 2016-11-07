require 'date'

# Class for storing user data and easy accessing it
class User
  private

  attr_reader :ds
  attr_accessor :user

  public

  attr_reader :user_id

  def initialize(user_id)
    @ds = DataStorage.instance
    @user_id = user_id
    @user = ds.user?(user_id) ? ds.get_user(user_id) : create_user
  end

  private

  def save(saved_user = user)
    ds.set_user(user_id, saved_user)
  end

  def create_user
    new_user = {}
    new_user['sem_start'] = nil
    new_user['sem_end'] = nil
    new_user['subjects'] = {}
    new_user['action'] = nil
    new_user['callback'] = nil
    new_user['callback_msg_id'] = nil
    save(new_user)
    new_user
  end

  public

  def delete
    ds.delete_user(user_id)
  end

  # Callbacks
  def callback=(value)
    user['callback'] = value
    save
  end

  def callback
    user['callback']
  end

  def callback?
    !callback.nil?
  end

  def callback_msg_id=(value)
    user['callback_msg_id'] = value
    save
  end

  def callback_msg_id
    user['callback_msg_id']
  end

  # Actions
  def set_action(action, *args)
    user['action'] = action.nil? ? nil : [action] + args
    save
  end

  def action
    user['action']
  end

  def action?
    !action.nil?
  end

  # Semester
  def sem_start=(value)
    user['sem_start'] = value
    save
  end

  def sem_start
    user['sem_start']
  end

  def sem_end=(value)
    user['sem_end'] = value
    save
  end

  def sem_end
    user['sem_end']
  end

  def sem_defined?
    !(sem_start && sem_end).nil?
  end

  def sem_time_length
    return nil unless sem_defined?
    (Time.at(sem_end).to_date - Time.at(sem_start).to_date).to_i
  end

  def sem_time_passed
    return nil unless sem_defined?
    (Date.today - Time.at(sem_start).to_date).to_i
  end

  def sem_time_left
    return nil unless sem_defined?
    (Time.at(sem_end).to_date - Date.today).to_i
  end

  def sem_passed_percent
    return nil unless sem_defined?
    sem_time_passed.to_f / sem_time_length
  end

  def sem_now?
    return nil unless sem_defined?
    sem_passed_percent >= 0 && sem_passed_percent <= 1
  end

  def sem_start_text
    return '' unless sem_defined?
    Time.at(sem_start).to_date.strftime('%d.%m.%Y')
  end

  def sem_end_text
    return '' unless sem_defined?
    Time.at(sem_end).to_date.strftime('%d.%m.%Y')
  end

  def sem_passed_percent_text
    return '' unless sem_now?
    (sem_passed_percent * 100).to_i.to_s
  end

  # Subjects
  def subject?(subj)
    user['subjects'].keys.map(&:downcase_rus).include?(subj.downcase_rus)
  end

  def add_subject(subj, labs)
    user['subjects'][subj] = Array.new(labs, false)
    save
  end

  def del_subject(subj)
    user['subjects'].delete(subj)
    save
  end

  def submit_subject_lab(subj, lab)
    user['subjects'][subj][lab] = true
    save
  end

  def subject(subj)
    user['subjects'][subj]
  end

  def subjects
    user['subjects']
  end

  def subjects?
    !subjects.empty?
  end
end

# Add downcase for cyrillic
class String
  def downcase_rus
    rus_down = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'
    rus_up = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ'
    downcase.tr(rus_up, rus_down)
  end
end
