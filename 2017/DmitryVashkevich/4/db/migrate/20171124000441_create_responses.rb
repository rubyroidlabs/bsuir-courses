# CreateResponses
class CreateResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :responses do |t|
      t.string :text
      t.integer :advert_id
      t.timestamps
    end
  end
end
