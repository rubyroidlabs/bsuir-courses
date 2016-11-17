class CreatePhrases < ActiveRecord::Migration[5.0]
  def change
    create_table :phrases do |t|
      t.text :content
      t.integer :last_user
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
