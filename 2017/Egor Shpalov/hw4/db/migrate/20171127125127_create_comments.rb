class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :content, null: false
      t.integer :user_id

      t.timestamps
    end
    add_index :comments, %i[user_id created_at]
  end
end
