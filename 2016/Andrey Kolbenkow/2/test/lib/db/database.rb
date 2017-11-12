require 'sqlite3'
require 'unicode_utils'
require_relative '../console.rb'

class Database
  attr_accessor :db

  def initialize
    @console = Console.new
    create_or_load
  end

  def create_or_load
    if db_exist?
      @console.db_detected
      @db = SQLite3::Database.new('lib/db/database.db')
    else
      @console.db_not_found
      File.open('lib/db/database.db', 'a+')
      @db = SQLite3::Database.new('lib/db/database.db')
      create_database
      @console.ok
    end
  end

  def db_exist?
    false
    true if File.exist?('lib/db/database.db')
  end

  def create_database
    @db.execute <<-SQL
    create table users(
      id    varchar,
      name  varchar,
      command varchar,
      dead_line varchar,
      submit_subj varchar,
      executed boolean
    );
    SQL
    @db.execute <<-SQL
     create table subjects(
       user_id varchar,
       subject varchar,
       count_of_labs int
    );
    SQL
    @db.execute <<-SQL
    create table labs(
      subject varchar,
      user_id varchar,
      lub_numb int
    );
    SQL
  end
end
