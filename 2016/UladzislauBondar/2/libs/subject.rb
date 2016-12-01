require_relative "command"
require "json"

module Command
  # Subject-command class
  class Subject < Base
    # Flags for getting current step
    NAME = 0
    WORKS = 1

    def self.name
      "/subject"
    end

    def process
      send_message("What subject are you going to pass?")
      @user.save_subject_step(NAME)
    end

    def process_subject
      @subject = text
      save_subject
      send_message("How many works does it have?")
      @user.save_subject_step(WORKS)
    end

    def process_quantity_of_works
      if positive_number?
        @quantity_of_works = text.to_i
        save_quantity_of_works
        send_message("Got it!")
        @user.save_command
      else
        send_message("Invalid number. Try again!")
      end
    end

    private

    def positive_number?
      text =~ /^\d+$/ && text.to_i.positive?
    end

    def save_subject
      hash = subjects
      hash[@subject] = []
      @user.save_subjects(hash)
    end

    def save_quantity_of_works
      hash = subjects
      hash.each do |k, v|
        next unless v.empty?
        hash_of_works = {}
        @quantity_of_works.times { |i| hash_of_works[i + 1] = true }
        hash[k] = hash_of_works
      end
      @user.save_subjects(hash)
    end

    def subjects
      JSON.parse(@user.subjects)
    end
  end
end

