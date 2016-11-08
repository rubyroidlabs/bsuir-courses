require "ohm/datatypes"

module Bot
  class User < Ohm::Model #:nodoc:
    include Ohm::DataTypes

    attribute :telegram_id
    attribute :first_name
    attribute :last_name

    reference :semester,     "Bot::Semester"
    reference :next_command, "Bot::NextCommand"
    reference :callback,     "Bot::CallbackContainer"
    reference :notification, "Bot::Notification"
    set       :subjects,     "Bot::Subject"

    index     :telegram_id
    unique    :telegram_id

    def subjects_present?
      subjects && !subjects.size.zero?
    end

    def subject_exist?(name)
      !subjects.find(name: name).first.nil?
    end

    def can_notify?
      notice = notification
      last_sent = notice.last_sent
      check = !last_sent || (last_sent - Date.today).round >= notice.period
      notice.status && check
    end

    def destroy
      subjects.each { |s| subjects.delete(s) }
      semester&.delete
      next_command&.delete
      callback&.delete
      delete
    end

    def self.find_or_create_by(from)
      user = User.find(telegram_id: from.id).first
      user || User.create(
        telegram_id:  from.id,
        first_name:   from.first_name,
        last_name:    from.last_name,
        semester:     Bot::Semester.create,
        next_command: Bot::NextCommand.create,
        callback:     Bot::CallbackContainer.create,
        notification: Bot::Notification.create
      )
    end

    alias assigin_id id=

    def id=(id)
      assigin_id(id)
    end
  end
end
