# Migration for User class
class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false, index: true
    end
  end
end
