require 'json'
require 'redis'

class Database

  def initialize
    @database = Redis.new
  end

  def update(data, user_id)
    user = get_user(user_id)
    keys = data.keys
    keys.each { |key| user[key.to_s] = data[key] }

    save_user(user, user_id)
  end

  def get_token
    @database.get('token')
  end

  def get_user(user_id)
    JSON.parse(@database.get('users'))[user_id.to_s]
  end

  def get_users
    JSON.parse(@database.get('users'))
  end

  def create_user(user_id)
    user = {
        'subjects' => {},
        'start_date' => '',
        'finish_date' =>  '',
        'available_days' => '',
        'reminders' => []
    }
    save_user(user, user_id)

    user
  end

  private

  def save_user(user, user_id)
    users = JSON.parse(@database.get('users'))
    users[user_id.to_s] = user

    @database.set('users', users.to_json)
  end

end

# database struct

 # database: {
 #     users: {
 #         user_id: {
 #             subjects: {
 #                 mrz: {
 #                     labs_count: 10,
 #                     made_labs: [2, 4, 5, 6]
 #                 },
 #                 ppvis: {
 #                     labs_count: 10,
 #                     labs: [2, 4, 5, 6]
 #                 }},
 #             start_date: '01-09-2016',
 #             finish_date: '03-11-2016',
 #             available_days: '123',
 #             reminders: [{
 #                 days: 1,
 #                 hour: 12
 #             }]
 #         },
 #         another_user_id: {
 #             subjects: {
 #                 mrz: {
 #                     labs_count: 10,
 #                     made_labs: [2, 4, 5, 6]
 #                 },
 #                 ppvis: {
 #                     labs_count: 10,
 #                     made_labs: [2, 4, 5, 6]
 #                 }},
 #             start_date: '01-09-2016',
 #             finish_date: '03-11-2016',
 #             available_days: '123',
 #             reminders: [{
 #                  day: 1,
 #                  hour: 12
 #             }]
 #         }
 #     },
 #     token: 'ax123r123s13ies3n123esy123e'
 # }
