require 'active_record'
require "../models/connection"
class CreateMessages < ActiveRecord::Migration[5.0]
  def up
    create_table :messages do |t|
      t.text :message
      t.references :user
      t.timestamps
    end
  end
  def down
    drop_table :message
  end
end
CreateMessages.new.up
