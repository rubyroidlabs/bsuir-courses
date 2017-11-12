# Migration for Word class

class CreatePhrase < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
      t.belongs_to :user
      t.string :phrase
      t.timestamps null: true
    end
  end
end
