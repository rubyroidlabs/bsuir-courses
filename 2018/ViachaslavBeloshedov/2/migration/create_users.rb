require 'active_record'
require "../models/connection"
class CreateUsers < ActiveRecord::Migration[5.0]
  def up
    create_table :users do |t|
      t.integer :user_id
      t.string :current_repo, default:''
      t.timestamps
    end
  end
  def down
    drop_table :users
  end
end
CreateUsers.new.up
