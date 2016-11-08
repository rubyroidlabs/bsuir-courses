require "ohm/datatypes"

module Bot
  class Semester < Ohm::Model #:nodoc:
    include Ohm::DataTypes

    attribute :start,  Type::Date
    attribute :finish, Type::Date
    reference :user,   "Bot::User"

    def number_days
      (finish - start).round + 1
    end

    def days_left
      (finish - Date.today).round + 1
    end

    def present?
      start.instance_of?(Date) && finish.instance_of?(Date)
    end

    def required_coefficient
      current_date = Date.parse(Time.now.to_s)
      ((current_date - start) / (finish - start)).to_f
    end

    alias assigin_id id=

    def id=(id)
      assigin_id(id)
    end
  end
end
