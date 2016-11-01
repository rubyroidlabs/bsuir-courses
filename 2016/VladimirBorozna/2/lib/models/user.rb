require 'ohm/datatypes'

module Bot
  class User < Ohm::Model #:nodoc:
    include Ohm::DataTypes

    attribute :telegram_id
    attribute :first_name
    attribute :last_name

    attribute :semester_start, Type::Date
    attribute :semester_finish, Type::Date

    attribute :command
    attribute :method
    attribute :data

    set :subjects, 'Bot::Subject'

    index     :telegram_id
    unique    :telegram_id

    def semester_present?
      result =  semester_start.instance_of?(Date)
      result && semester_finish.instance_of?(Date)
    end

    def subjects_present?
      subjects && !subjects.size.zero?
    end

    def subject_present?(name)
      !subjects.find(name: name).empty?
    end

    def next_command(command = nil, method = nil)
      update(command: command, method: method)
    end

    def next_command_data(data = nil)
      update(data: data)
    end

    def command_data
      data
    end

    def reset_next_command
      update(command: nil, method: nil, data: nil)
    end

    def destroy
      subjects.map(&:delete)
      update(semester_start: nil, semester_finish: nil)
    end

    def self.find_or_create_by(from)
      user = User.with(:telegram_id, from[:id])
      user || User.create(
        telegram_id: from[:id],
        first_name:  from[:first_name],
        last_name:   from[:last_name]
      )
    end
  end
end
