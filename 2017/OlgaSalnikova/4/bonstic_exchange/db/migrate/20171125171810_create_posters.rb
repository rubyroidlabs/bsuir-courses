# used for creating table of db
class CreatePosters < ActiveRecord::Migration[5.1]
  def change
    create_table :posters do |t|
      t.string :title, null: false
      t.text :text
      t.string :contact

      t.timestamps
    end
  end
end
