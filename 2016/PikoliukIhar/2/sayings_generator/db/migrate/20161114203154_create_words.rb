class CreateWords < ActiveRecord::Migration[5.0]
  def change
    create_table :words do |t|
      t.string :user_word
      t.string :user_name
      t.references :saying, foreign_key: true

      t.timestamps
    end
  end
end
