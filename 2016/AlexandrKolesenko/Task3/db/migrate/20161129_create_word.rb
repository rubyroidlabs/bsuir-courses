# Migration for Word class
class CreateWord < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.belongs_to :user, index: true
      t.belongs_to :phrase, index: true
      t.string :word, null: false
    end
  end
end
