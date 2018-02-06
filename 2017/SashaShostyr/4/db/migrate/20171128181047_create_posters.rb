class CreatePosters < ActiveRecord::Migration[5.1]
  def change
    create_table :posters do |t|
      t.string :title, null: false, default: ''
      t.string :description, null: false, default: ''
      t.string :contacts, null: false, default: ''

      t.timestamps
    end
  end
end
