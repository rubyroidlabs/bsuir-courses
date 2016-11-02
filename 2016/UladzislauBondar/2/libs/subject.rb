require_relative 'command'
require 'json'

module Command
  # Subject-command class
  class Subject < Base
    @@subject_entered = false

    def self.name
      "/subject"
    end

    def self.subject_entered
      @@subject_entered
    end

    def process
      send_message("What subject are you going to pass?")
    end

    def process_subject
      @subject = text
      @@subject_entered = true
      save_subject
      send_message("How many works does it have?")
    end

    def process_quantity_of_works
      if positive_number?
        @quantity_of_works = text.to_i
        @@subject_entered = false
        save_quantity_of_works
        send_message("Got it!")
        save_user_command
      else
        send_message("Invalid number. Try again!")
      end
    end

    private

    def positive_number?
      text =~ /^\d+$/ && text.to_i > 0
    end

    def save_subject
      hash = hash_of_subjects
      hash[@subject] = -1
      save_hash_of_subjects(hash)
    end

    def save_quantity_of_works
      hash = hash_of_subjects
      hash.select do |k, v|
        if v == -1
          hash[k] = @quantity_of_works
          break
        end
      end
      save_hash_of_subjects(hash)
    end

    def subjects
      @redis.hget('users_subjects', user_id)
    end

    def hash_of_subjects
      JSON.parse(subjects)
    end

    def save_hash_of_subjects(hash)
      @redis.hset('users_subjects', user_id, hash.to_json)
    end
  end
end
