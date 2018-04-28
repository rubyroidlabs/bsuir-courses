# frozen_string_literal: true

class DataBase
  def self.establish_connection
    connection_details = YAML.safe_load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details)
  end
end
