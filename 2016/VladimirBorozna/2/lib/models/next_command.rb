require "ohm/datatypes"

module Bot
  class NextCommand < Ohm::Model #:nodoc:
    include Ohm::DataTypes

    attribute :name
    attribute :method
    attribute :data

    reference :user, "Bot::User"

    def reset
      update(name: nil, method: nil, data: nil)
    end

    def set(name = nil, method = nil)
      update(name: name, method: method)
    end
  end
end
