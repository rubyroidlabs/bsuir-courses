require 'redis'
require 'singleton'
require 'json'
require 'xmlsimple'
require 'net/http'
require_relative 'secret.rb'

# Class for interaction with Redis cloud server
class DataStorage
  include Singleton

  GROUPS_LIST_URL = 'https://www.bsuir.by/schedule/rest/studentGroup'.freeze
  GROUP_SCHED_URL = 'https://www.bsuir.by/schedule/rest/schedule/'.freeze

  def initialize
    @redis = Redis.new(
      host: Secret::REDIS_HOST,
      port: Secret::REDIS_PORT,
      password: Secret::REDIS_PASS
    )
  end

  # Users
  def get_user(user_id)
    data = @redis.get(user_id.to_s)
    data.nil? ? nil : JSON.parse(data)
  end

  def set_user(user_id, user)
    @redis.set(user_id.to_s, user.to_json)
  end

  def delete_user(user_id)
    @redis.del(user_id.to_s)
  end

  def user?(user_id)
    @redis.exists(user_id.to_s)
  end

  # Reminders
  def reminders
    data = @redis.get('reminders')
    data.nil? ? nil : JSON.parse(data)
  end

  def reminders=(reminders)
    @redis.set('reminders', reminders.to_json)
  end

  def reminders?
    @redis.exists('reminders')
  end

  # Groups
  def get_group_subjects(group)
    group_subjects(group) if group_exists?(group)
  end

  def group_exists?(group)
    !groups_list[group.to_s].nil?
  end

  private

  def group_subjects(group)
    data = get_xml_from_url(GROUP_SCHED_URL + group_url(group))
    result = []
    data['scheduleModel'].each do |day|
      day['schedule'].each do |subject|
        result.push(subject['subject'][0]) if subject_needs_adding?(subject)
      end
    end
    result.uniq
  end

  def subject_needs_adding?(subject)
    subject['lessonType'][0] =~ /(ЛР|ПЗ)/ &&
      !(subject['subject'][0] =~ /ФизК/)
  end

  def update_all_groups
    xml_data = Net::HTTP.get_response(URI.parse(GROUPS_LIST_URL)).body
    data = XmlSimple.xml_in(xml_data)
    result = {}
    data['studentGroup'].each { |gr| result[gr['name'][0]] = gr['id'][0] }
    @redis.set('groups', result.to_json)
  end

  def groups_list
    data = @redis.get('groups')
    if data.nil?
      update_all_groups
      data = @redis.get('groups')
    end
    JSON.parse(data)
  end

  def group_url(group)
    groups_list[group.to_s]
  end

  def get_xml_from_url(url)
    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    XmlSimple.xml_in(xml_data)
  end
end
