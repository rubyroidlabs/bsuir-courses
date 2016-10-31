require "./environment"

include Environment
# describe user and actions with him
class User
  attr_reader :id
  attr_accessor :semester, :subjects, :next_bot_command

  def initialize(id)
    @id = id
    @first_name = ""
    @last_name = ""
    @semester = { start: nil, finish: nil }
    @subjects = {}
    @next_bot_command = { class: nil, method: nil, data: nil }
  end

  def to_s
    "id=#{@id}\n" \
    "first_name=#{@first_name}\n" \
    "last_name=#{@last_name}\n" \
    "semester=#{@semester}\n" \
    "subjects=#{@subjects}\n" \
    "next_bot_command=#{@next_bot_command}\n"
  end

  def clean_all_data
    @semester.update(@semester) { nil }
    @subjects.clear
    reset_next_bot_command
  end

  def self.find_or_initialize_by(id)
    user = find_by(id)
    user.nil? ? new(id) : user
  end

  def self.find_by(id)
    user = Environment.redis.get(id.to_s)
    user.nil? ? nil : YAML.load(user)
  end

  def save
    Environment.redis.set(id.to_s, YAML.dump(self))
  end

  def reset_next_bot_command
    @next_bot_command.update(@next_bot_command) { nil }
  end

  def update_attributes!(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end
end
