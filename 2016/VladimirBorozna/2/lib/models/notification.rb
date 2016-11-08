require "date"
require "ohm/datatypes"

module Bot
  class Notification < Ohm::Model #:nodoc:
    include Ohm::DataTypes

    attribute :status,    Type::Boolean
    attribute :weekday,   Type::Integer
    attribute :period,    Type::Integer
    attribute :last_sent, Type::Date

    reference :user, "Bot::User"
  end
end
