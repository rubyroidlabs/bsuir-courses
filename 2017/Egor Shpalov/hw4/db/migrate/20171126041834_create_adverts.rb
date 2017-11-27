class CreateAdverts < ActiveRecord::Migration[5.1]
  def change
    create_table :adverts do |t|
      t.string :title, null: false
      t.string :content, null: false
      t.integer :user_id

      t.timestamps
    end
    add_index :adverts, [:user_id, :created_at]
  end
end
