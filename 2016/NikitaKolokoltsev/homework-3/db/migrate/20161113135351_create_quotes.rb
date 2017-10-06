# Create Quotes
class CreateQuotes < ActiveRecord::Migration[5.0]
  def change
    create_table :quotes do |t|
      t.references :user
      t.integer :last_user_edited

      t.timestamps
    end
  end
end
