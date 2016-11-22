class CreatePhrases < ActiveRecord::Migration[5.0]
  def change
    create_table :phrases do |t|
      t.integer :user_id, null: false
      t.string :created_at, null: false
      t.string :value, null: false
      t.integer :last_changer, null: false
    end
  end
end
