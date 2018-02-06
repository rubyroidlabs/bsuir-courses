class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.integer :bonsticks, null: false
      t.decimal :bitcoins, precision: 17, scale: 15, null: false
      t.text :description, null: false
      t.text :contacts, null: false
      t.text :operation, null: false

      t.timestamps
    end
  end
end
