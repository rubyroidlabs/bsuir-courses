# used for creating table of db
class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :comment, null: false
      t.string :contact
      t.references :poster, foreign_key: true
      t.timestamps
    end
  end
end
