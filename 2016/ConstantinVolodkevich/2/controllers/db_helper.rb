require './models/user'
require 'redis'
require 'json'


class DB_Helper

  attr_accessor :redis

  def initialize
  @redis = Redis.new
  end

  def save_user(id, first_name, last_name)
    if @redis.get(id) == nil
      user = User.new(first_name, last_name)
      @redis.set id, to_json(user)
    end
  end

  def update_user(id, user)
    @redis.set id, to_json(user)
  end

  def get_user(id)
    json_str = JSON.parse(@redis.get(id))
    p '+'*30
    p json_str['hash_of_subjects']
    user = User.new(json_str['name'], json_str['last_name'])
    user.user_status.steps_semester = json_str['user_status']['steps_semester']
    user.user_status.steps_subject = json_str['user_status']['steps_subject']
    user.user_status.steps_submit = json_str['user_status']['steps_submit']
    user.user_status.steps_reset = json_str['user_status']['steps_reset']
    begin
    user.semester.ending_date = Date.parse json_str['semester']['ending_date']
    rescue ArgumentError
      user.semester.ending_date = ''#handle invalid date
    end
    user.status = json_str['status']
    json_str['hash_of_subjects'].each do |sbj_name, hash_of_labs|
      subj = Subject.new
      hash_of_labs.each do |lab_name, status_pair|
        lab = Lab.new
        lab.status = status_pair['status']
        subj.hash_of_labs[lab_name] = lab
        end
        user.hash_of_subjects[sbj_name]= subj
    end
    user
  end

  def to_json(user)
    #p '-'*30
    #p user.hash_of_subjects
    hash_labs = {}
    hash = {}
    user.hash_of_subjects.each do |subj_name, subj|
      subj.hash_of_labs.each do |lab_name, lab|
        hash_labs[lab_name] = {'status' => lab.status}
      end
      hash[subj_name] = hash_labs
      hash_labs = {}
    end
    json = {'user_status' => {'steps_semester' => user.user_status.steps_semester,
                              'steps_subject' => user.user_status.steps_subject,
                              'steps_submit' => user.user_status.steps_submit,
                              'steps_reset' => user.user_status.steps_reset},
            'semester' => {'ending_date' => user.semester.ending_date},
            'status' => user.status,
            'hash_of_subjects' => hash,
            'name' => user.name,
            'last_name' => user.last_name}.to_json
    json
  end
end

