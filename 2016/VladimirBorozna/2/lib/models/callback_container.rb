require "ohm/datatypes"

module Bot
  class CallbackContainer < Ohm::Model #:nodoc:
    include Ohm::DataTypes

    attribute :data
    attribute :message_id, Type::Integer
    reference :user,       "Bot::User"
  end
end
