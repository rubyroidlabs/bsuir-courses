require_relative 'action'
require_relative 'user'
require_relative 'semester'
require 'time_difference'

class Status < Action
  def run
    if @user.sem["start"].nil? or @user.sem["end"].nil?
      return "First you need to set semester dates (try '/semester')."
    end
    index = calculate
    result = "Semester: #{@user.sem['start']}  :  #{@user.sem['end']}.\nToday: #{Date.today}.\n"
    result += "You need to do:\n" if @user.get_subject_items.length > 0
    @user.get_subject_items.each do |subject, labs|
      result += get_count(subject, labs, index)
    end
    result
  end

  def calculate
    start = Time.parse(@user.sem["start"])
    finish = Time.parse(@user.sem["end"])
    now = Time.now
    full_time = TimeDifference.between(start, finish).in_days
    wasted_time = TimeDifference.between(start, now).in_days
    return (wasted_time.to_f / full_time)
  end

  def get_count(subject, all_labs, k)
    required_number = (k * all_labs.length).round
    required_labs = all_labs[0...required_number]
    "#{subject} - #{required_labs.join(' ')}\n"
  end
end