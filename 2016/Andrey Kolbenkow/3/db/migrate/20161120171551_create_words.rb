class CreateWords < ActiveRecord::Migration[5.0]
  def change
    create_table :words do |t|
      t.integer :phrase_id, null: false
      t.integer :user_id, null: false
      t.string :added_at, null: false
      t.string :value, null: false
    end
  end
end
