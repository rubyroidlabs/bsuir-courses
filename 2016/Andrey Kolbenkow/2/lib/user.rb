require_relative 'db/database.rb'
require 'unicode_utils'
require 'sqlite3'
class User
  attr_accessor :name, :id

  def initialize
    @database = Database.new
  end

  def parse(message)
    @name = [message.from.first_name, message.from.last_name].reject(&nil).to_a.join(' ')
    @id = message.from.id
  end

  def not_exist?
    @database.db.execute('SELECT * FROM users  WHERE id = ?', id).eql?([]) ? true : false
  end

  def create
    @database.db.execute('INSERT INTO users(id, name, command, dead_line, executed) VALUES(?,?,?,?,?)', [id, name, 'waiting', ' ', 'false'])
  end

  def get_command
    @database.db.execute('SELECT command FROM users WHERE id = ? ', id).flatten[0]
  end

  def delete_subject_if_cancel
    @database.db.execute("DELETE FROM subjects WHERE user_id = '#{id}' and rowid in (SELECT max(rowid) from subjects WHERE user_id = '#{id}')")
  end

  def set_submit_subject(subject)
    @database.db.execute('UPDATE users SET submit_subj = ? WHERE id = ?', subject, id)
  end

  def get_submit_subject
    @database.db.execute('SELECT submit_subj FROM users WHERE id = ?', id).flatten[0]
  end

  def set_deadline(date)
    @database.db.execute('UPDATE users SET dead_line = ? WHERE id = ?', date, id)
  end

  def get_deadline
    @database.db.execute('SELECT dead_line FROM users WHERE id = ?', id)
  end

  def set_executed(value)
    @database.db.execute('UPDATE users SET executed = ? WHERE id = ?', value, id)
  end

  def dead_line_executed?
    @database.db.execute('SELECT executed FROM users WHERE id = ?', id).flatten[0].eql?('true') ? true : false
  end

  def add_count_of_labs(count)
    @database.db.execute("UPDATE subjects SET count_of_labs = ? WHERE user_id = ? and rowid in (SELECT max(rowid) from  subjects WHERE user_id = '#{id}')", count, id)
  end

  def subject_not_exist?(subj)
    subj = UnicodeUtils.downcase(subj)
    @database.db.execute('SELECT rowid FROM subjects WHERE subject = ? and user_id = ? ', subj, id).flatten.eql?([]) ? true : false
  end

  def add_subject(subj)
    @database.db.execute('INSERT INTO subjects(user_id, subject) VALUES(?,?)', id, subj) if subject_not_exist?(subj)
  end

  def get_subjects
    @database.db.execute('SELECT subject FROM subjects WHERE user_id = ?', id).flatten
  end

  def set_next_command(command)
    @database.db.execute('UPDATE users SET command = ? WHERE id = ?', command, id)
  end

  def labs(subj)
    @database.db.execute('SELECT lub_numb FROM labs WHERE user_id = ? and  subject = ?', id, subj).flatten
  end

  def add_lab(lab)
    subj = @database.db.execute('SELECT subject FROM subjects WHERE user_id = ? ', id).flatten.last
    @database.db.execute("INSERT INTO labs(user_id, subject, lub_numb) VALUES('#{id}','#{subj}', '#{lab}')")
  end

  def submit(subject, lab)
    @database.db.execute("DELETE FROM labs WHERE subject = '#{subject}' and lub_numb = '#{lab}' and user_id = ?", id)
    count = @database.db.execute('SELECT count_of_labs FROM subjects WHERE user_id = ? and subject = ?', id, subject).flatten[0] - 1
    @database.db.execute('UPDATE subjects SET count_of_labs = ? WHERE user_id = ? and subject = ? ', count, id, subject)
    @database.db.execute('DELETE FROM subjects WHERE count_of_labs = 0')
  end

  def delete
    @database.db.execute('DELETE FROM users WHERE id = ?', id)
    @database.db.execute('DELETE FROM subjects WHERE user_id = ?', id)
    @database.db.execute('DELETE FROM labs WHERE user_id = ?', id)
  end
end
