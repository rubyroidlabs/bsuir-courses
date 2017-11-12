require_relative "action"
require_relative "user"
require_relative "semester"
require "time_difference"

# Class Status.
class Status < Action
  def run
    if empty_semester?
      return %(First you need to set semester dates (try "/semester").)
    end
    result = %(Semester: #{@user.semester['start']}  :  #{@user.semester['end']}.\nToday: #{Date.today.to_s.tr!('-', '.')}.\n)
    result << "\nYou need to do:\n" unless @user.subjects.empty?
    print_subjects_with_labs(result)
    result
  end

  def empty_semester?
    @user.semester["start"].nil? || @user.semester["end"].nil?
  end

  def print_subjects_with_labs(string)
    @user.subjects.each do |subject, labs|
      string << count(subject, labs, calculate)
    end
  end

  def calculate
    start = Time.parse(@user.semester["start"])
    finish = Time.parse(@user.semester["end"])
    now = Time.now
    full_time = TimeDifference.between(start, finish).in_days
    wasted_time = TimeDifference.between(start, now).in_days
    wasted_time.to_f / full_time
  end

  def count(subject, all_labs, k)
    required_number = (k * all_labs.length).round
    required_labs = all_labs[0...required_number]
    "#{subject}: #{required_labs.join(' ')}\n"
  end
end
