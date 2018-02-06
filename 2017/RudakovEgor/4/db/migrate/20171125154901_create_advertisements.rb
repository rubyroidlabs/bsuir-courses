class CreateAdvertisements < ActiveRecord::Migration[5.1]
  def change
    create_table :advertisements do |t|
      t.string :title
      t.text :description
      t.text :contacts
      t.string :deal

      t.timestamps
    end
  end
end
