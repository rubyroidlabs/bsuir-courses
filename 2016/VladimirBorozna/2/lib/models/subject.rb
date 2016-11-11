require "date"
require "ohm/datatypes"

module Bot
  class Subject < Ohm::Model #:nodoc:
    include Ohm::DataTypes

    attribute :name
    attribute :total_number, Type::Integer
    attribute :accepted_numbers, Type::Array

    reference :user, "Bot::User"
    index :name

    def any?
      size.positive?
    end

    def name_present?(name)
      find(name: name.downcase).size.positive?
    end

    def remaining_numbers
      (1..total_number).to_a - accepted_numbers
    end

    def required_numbers(coeff)
      required_number = (total_number * coeff).ceil
      offset = [required_number - accepted_numbers.size, 0].max
      remaining_numbers.first(offset)
    end
  end
end
