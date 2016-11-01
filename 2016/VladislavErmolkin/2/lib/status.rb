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
    result = "You need to do:\n"
    p @user.get_subject_items
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
    puts full_time, wasted_time
    return wasted_time.to_f / full_time
  end

  def get_count(subject, all_labs, k)
    required_labs = (k * all_labs).round
    "#{subject} - #{required_labs} of #{all_labs}\n"
  end
end