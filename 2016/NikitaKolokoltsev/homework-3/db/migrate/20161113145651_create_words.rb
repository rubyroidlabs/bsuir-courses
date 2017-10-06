# Create Words
class CreateWords < ActiveRecord::Migration[5.0]
  def change
    create_table :words do |t|
      t.string :text, null: false
      t.references :quote
      t.references :user

      t.timestamps
    end
  end
end
